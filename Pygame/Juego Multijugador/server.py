# LIBRERÍAS
import socket, pickle, sqlite3
from threading import Thread

# CLASES
class Client(Thread):
    def __init__(self, connection, address):
        Thread.__init__(self)

        self.connection = connection
        self.address = address
        self.datos_recibidos = []

    def run(self):
        try:
            msg_crudo = self.connection.recv(1024).decode()
            self.datos_recibidos = desencriptar_msg(msg_crudo)


        except Exception as e:
            print("Error: %s." % e)

    def obtener_datos(self):
        return self.datos_recibidos

# VARIABLES
HOST = 'localhost'
PORT = 1234
lista_clientes = []

# FUNCIONES
def desencriptar_msg(msg: str):
    nom = msg[:-1]
    sel = int(msg[-1])
    return [nom, sel]

def ganador_a_bbdd(nombre):
    cxn = sqlite3.connect('ranking.db')
    cur = cxn.cursor()

    nombre=(nombre,)
    valores=(nombre[-1],1)

    try:
        cur.execute("INSERT INTO RANKING VALUES(?,?);",valores)

    except sqlite3.IntegrityError:
        cur.execute("SELECT Victorias from RANKING where Nombre=?", nombre)
        victoria=cur.fetchall()
        aniadir=victoria[0][0]+1
        valores_actualizar=(aniadir,nombre[-1])
        cur.execute("UPDATE RANKING SET Victorias=? where Nombre=?", valores_actualizar)

    cxn.commit()
    return


def juego(jugador1: list, jugador2: list):
    elementos = ["Piedra", "Papel", "Tijera", "Lagarto", "Spock"]
    jugador_a = elementos[jugador1[1] - 1]
    jugador_b = elementos[jugador2[1] - 1]

    # Asegurarnos de que los pares se comparan correctamente.
    if jugador_a == jugador_b:
        return 'empate'
    elif (jugador_a == "Piedra" and (jugador_b == "Tijera" or jugador_b == "Lagarto")) or \
         (jugador_a == "Papel" and (jugador_b == "Piedra" or jugador_b == "Spock")) or \
         (jugador_a == "Tijera" and (jugador_b == "Papel" or jugador_b == "Lagarto")) or \
         (jugador_a == "Lagarto" and (jugador_b == "Spock" or jugador_b == "Papel")) or \
         (jugador_a == "Spock" and (jugador_b == "Tijera" or jugador_b == "Piedra")):
        ganador_a_bbdd(jugador1[0])
        return jugador1[0]
    else:
        ganador_a_bbdd(jugador2[0])
        return jugador2[0]

def jugar_partida(jugador1, jugador2):
    seleccion_j1 = jugador1.obtener_datos()
    seleccion_j2 = jugador2.obtener_datos()

    ganador = juego(seleccion_j1, seleccion_j2)
    lista_ganador = [seleccion_j1[0], seleccion_j2[0], seleccion_j1, seleccion_j2, ganador]

    msg_ganador = pickle.dumps(lista_ganador)
    jugador1.connection.send(msg_ganador)
    jugador2.connection.send(msg_ganador)

    return ganador

def main():
    # BASE DE DATOS
    cxn = sqlite3.connect('ranking.db')
    cur = cxn.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS RANKING (Nombre varchar(50) NOT NULL primary key, Victorias int);")

    # SOCKET
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((HOST, PORT))
    server_socket.listen()
    print("Esperando conexiones de clientes...")

    while True:
        connection, address = server_socket.accept()
        client = Client(connection, address)
        client.start()
        client.join()
        print("%s:%d se ha conectado." % address)

        lista_clientes.append(client)

        # Procesamiento de clientes
        if len(lista_clientes) >= 2:
            obj_jugador_1 = lista_clientes.pop(0)
            obj_jugador_2 = lista_clientes.pop(0)

            jugadas = 0
            while jugadas < 3:
                ganador = jugar_partida(obj_jugador_1, obj_jugador_2)
                if ganador != 'empate':
                    jugadas += 1

                # Reinicia la conexión y espera la nueva entrada del cliente
                obj_jugador_1 = Client(obj_jugador_1.connection, obj_jugador_1.address)
                obj_jugador_2 = Client(obj_jugador_2.connection, obj_jugador_2.address)
                obj_jugador_1.start()
                obj_jugador_2.start()
                obj_jugador_1.join()
                obj_jugador_2.join()

            obj_jugador_1.connection.close()
            obj_jugador_2.connection.close()

if __name__ == "__main__":
    main()