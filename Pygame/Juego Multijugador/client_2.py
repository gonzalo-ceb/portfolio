#LIBRERÍAS
import socket, interfaz, random, pickle

# VARIABLES CLIENTE
HOST = 'localhost'
PORT = 1234

# FUNCIONES
def juego(jugador1: list, jugador2: list):
    elementos = ["Piedra", "Papel", "Tijera", "Lagarto", "Spock"]
    jugador_a = elementos[jugador1[1] - 1]
    jugador_b = elementos[jugador2[1] - 1]

    if jugador_a == jugador_b:
        return 'empate'
    elif (jugador_a == "Piedra" and (jugador_b == "Tijera" or jugador_b == "Lagarto")) or \
         (jugador_a == "Papel" and (jugador_b == "Piedra" or jugador_b == "Spock")) or \
         (jugador_a == "Tijera" and (jugador_b == "Papel" or jugador_b == "Lagarto")) or \
         (jugador_a == "Lagarto" and (jugador_b == "Spock" or jugador_b == "Papel")) or \
         (jugador_a == "Spock" and (jugador_b == "Tijera" or jugador_b == "Piedra")):
        return jugador1[0]
    else:
        return jugador2[0]

def encriptar_msg(nom:str, sel:int):
    msg = nom + str(sel)
    return msg

def main():
    interfaz.menu_inicio()
    interfaz.menu_instrucciones()
    if interfaz.menu_principal() == 1:
        print('\033[31mEsperando conexión con el servidor\n')
        try:
            client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            client_socket.connect((HOST, PORT))
            print('\033[32mConexión establecida\n')

            nombre_jugador = interfaz.menu_nombre()
            print(f'\033[0mTu nombre: \033[34;1m{nombre_jugador}\033[0m\n')
            interfaz.menu_3partidas()

            jugadas = 1
            partidas_ganadas = 0
            while jugadas < 4:
                seleccion = interfaz.menu_juego()
                print(f'\033[0mTu selección: \033[34;1m{seleccion}\033[0m\n')

                msg_encriptado = encriptar_msg(nombre_jugador, seleccion)
                client_socket.send(msg_encriptado.encode())

                ganador_datos = client_socket.recv(1024)
                ganador_datos = pickle.loads(ganador_datos)
                nombre_1 = ganador_datos[0]
                nombre_2 = ganador_datos[1]
                seleccion_j1 = ganador_datos[2][1]
                seleccion_j2 = ganador_datos[3][1]
                resultado_ganador = ganador_datos[4]
                interfaz.menu_resultado(nombre_1, nombre_2, seleccion_j1, seleccion_j2, resultado_ganador)
                if resultado_ganador != 'empate':
                    jugadas += 1
                if resultado_ganador == nombre_jugador:
                    partidas_ganadas += 1

            if partidas_ganadas >= 2:
                interfaz.ganador_perdedor(2)
            else:
                interfaz.ganador_perdedor(1)
            interfaz.menu_ranking()
            client_socket.close()

        except Exception as e:
            interfaz.menu_error(str(e))

    else:
        jugadas = 1
        nombre = interfaz.menu_nombre()
        interfaz.menu_3partidas()
        lista_ganador = []
        while jugadas < 4:
            seleccion_jugador = interfaz.menu_juego()
            seleccion_maquina = random.randint(1, 5)
            resultado = juego(['Máquina', seleccion_maquina], [nombre, seleccion_jugador])
            interfaz.menu_resultado('Máquina', nombre, seleccion_maquina, seleccion_jugador, resultado)

            if resultado != 'empate':
                jugadas += 1
                if resultado != 'Máquina':
                    lista_ganador.append(2) # 2 -> JUGADOR
                else:
                    lista_ganador.append(1) # 1 <- MÁQUINA

        # Contamos cuántas veces ha ganado cada el jugador y la máquina
        contar_maquina = lista_ganador.count(1)
        contar_jugador = lista_ganador.count(2)

        if contar_maquina > contar_jugador:
            interfaz.ganador_perdedor(1)  # Gana máquina
        elif contar_maquina < contar_jugador:
            interfaz.ganador_perdedor(2)  # Gana jugador
        interfaz.menu_adios()

if __name__ == "__main__":
    main()