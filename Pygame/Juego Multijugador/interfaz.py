import pygame, botones, time, sqlite3

#PYGAME
pygame.init()
pygame.display.set_caption('Piedra Papel Tijera')
screen = pygame.display.set_mode((1280, 832))

def menu_inicio():
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_inicio.png").convert()
    boton_jugar_imagen = pygame.image.load('imagenes/boton_jugar.png').convert_alpha()
    # BOTONES
    boton_jugar = botones.boton(452, 442, boton_jugar_imagen, 1)

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        if boton_jugar.draw(screen):
            break
        pygame.display.update()

def menu_instrucciones():
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_instrucciones.png").convert()
    boton_next_imagen = pygame.image.load('imagenes/boton_next.png').convert_alpha()
    # BOTONES
    boton_next = botones.boton(1030, 61, boton_next_imagen, 1)

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        if boton_next.draw(screen):
            break
        pygame.display.update()

def menu_principal():
    time.sleep(0.2)
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_fondo.png").convert()
    boton_multijugador_imagen = pygame.image.load('imagenes/boton_multijugador.png').convert_alpha()
    boton_vsmaquina_imagen = pygame.image.load('imagenes/boton_vsmaquina.png').convert_alpha()
    boton_salir_imagen = pygame.image.load('imagenes/boton_salir.png').convert_alpha()
    # BOTONES
    boton_multijugador = botones.boton(468, 318, boton_multijugador_imagen, 1)
    boton_vsmaquina = botones.boton(468, 452, boton_vsmaquina_imagen, 1)
    boton_salir = botones.boton(553, 586, boton_salir_imagen, 1)

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        if boton_multijugador.draw(screen):
            return 1
        if boton_vsmaquina.draw(screen):
            return 2
        if boton_salir.draw(screen):
            raise SystemExit
        pygame.display.update()

def menu_multijugador():
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_fondo.png").convert()
    boton_2jugadores_imagen = pygame.image.load('imagenes/boton_2jugadores.png').convert_alpha()
    boton_3jugadores_imagen = pygame.image.load('imagenes/boton_3jugadores.png').convert_alpha()
    boton_4jugadores_imagen = pygame.image.load('imagenes/boton_4jugadores.png').convert_alpha()
    boton_salir_imagen = pygame.image.load('imagenes/boton_salir.png').convert_alpha()
    # BOTONES
    boton_2jugadores = botones.boton(89, 375, boton_2jugadores_imagen, 1)
    boton_3jugadores = botones.boton(468, 375, boton_3jugadores_imagen, 1)
    boton_4jugadores = botones.boton(847, 375, boton_4jugadores_imagen, 1)
    boton_salir = botones.boton(554, 586, boton_salir_imagen, 1)

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        if boton_2jugadores.draw(screen):
            jugadores = 2
            return jugadores
        if boton_3jugadores.draw(screen):
            jugadores = 3
            return jugadores
        if boton_4jugadores.draw(screen):
            jugadores = 4
            return jugadores
        if boton_salir.draw(screen):
            raise SystemExit
        pygame.display.update()

def menu_nombre():
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_nombre.png").convert()
    boton_continuar_imagen = pygame.image.load('imagenes/boton_continuar.png').convert_alpha()
    # BOTONES
    boton_continuar = botones.boton(467, 529, boton_continuar_imagen, 1)
    # INTRO TEXTO
    active = False
    input_box = pygame.Rect(405, 385, 470, 65)
    color = pygame.Color((0, 31, 43))
    font = pygame.font.Font(None, 85)
    nombre = ''

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
            if event.type == pygame.MOUSEBUTTONDOWN:
                if input_box.collidepoint(event.pos):
                    active = not active
                else:
                    active = False
            if event.type == pygame.KEYDOWN:
                if active:
                    if event.key == pygame.K_RETURN:
                        if nombre.replace(" ", "") != '':
                            return nombre
                    elif event.key == pygame.K_BACKSPACE:
                        nombre = nombre[:-1]
                    elif len(nombre) < 13:
                        nombre += event.unicode
        if boton_continuar.draw(screen):
            if nombre.replace(" ", "") != '':
                return nombre

        txt_surface = font.render(nombre, True, (148, 233, 228))
        screen.blit(txt_surface, (input_box.x + 5, input_box.y + 5))
        pygame.draw.rect(screen, color, input_box, 2)
        pygame.display.flip()
        pygame.display.update()

def menu_juego():
    pressed = False
    time.sleep(0.2)
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_juego.png").convert()
    imagen_espera = pygame.image.load('imagenes/imagen_espera.png').convert_alpha()
    boton_piedra_imagen = pygame.image.load('imagenes/boton_piedra.png').convert_alpha()
    boton_papel_imagen = pygame.image.load('imagenes/boton_papel.png').convert_alpha()
    boton_tijera_imagen = pygame.image.load('imagenes/boton_tijeras.png').convert_alpha()
    boton_lagarto_imagen = pygame.image.load('imagenes/boton_lagarto.png').convert_alpha()
    boton_spock_imagen = pygame.image.load('imagenes/boton_spock.png').convert_alpha()
    boton_piedra_pulsado_imagen = pygame.image.load('imagenes/boton_piedra_pulsado.png').convert_alpha()
    boton_papel_pulsado_imagen = pygame.image.load('imagenes/boton_papel_pulsado.png').convert_alpha()
    boton_tijera_pulsado_imagen = pygame.image.load('imagenes/boton_tijeras_pulsado.png').convert_alpha()
    boton_lagarto_pulsado_imagen = pygame.image.load('imagenes/boton_lagarto_pulsado.png').convert_alpha()
    boton_spock_pulsado_imagen = pygame.image.load('imagenes/boton_spock_pulsado.png').convert_alpha()
    # BOTONES
    boton_piedra = botones.boton(287, 322, boton_piedra_imagen, 1)
    boton_papel = botones.boton(548, 322, boton_papel_imagen, 1)
    boton_tijera = botones.boton(824, 322, boton_tijera_imagen, 1)
    boton_lagarto = botones.boton(412, 534, boton_lagarto_imagen, 1)
    boton_spock = botones.boton(708, 534, boton_spock_imagen, 1)

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit

        if boton_piedra.draw(screen) and not pressed:
            seleccion = 1
            boton_piedra = botones.boton(287, 322, boton_piedra_pulsado_imagen, 1)
            pressed = True
        if boton_papel.draw(screen) and not pressed:
            seleccion = 2
            boton_papel = botones.boton(548, 322, boton_papel_pulsado_imagen, 1)
            pressed = True
        if boton_tijera.draw(screen) and not pressed:
            seleccion = 3
            boton_tijera = botones.boton(824, 322, boton_tijera_pulsado_imagen, 1)
            pressed = True
        if boton_lagarto.draw(screen) and not pressed:
            seleccion = 4
            boton_lagarto = botones.boton(412, 534, boton_lagarto_pulsado_imagen, 1)
            pressed = True
        if boton_spock.draw(screen) and not pressed:
            seleccion = 5
            boton_spock = botones.boton(708, 534, boton_spock_pulsado_imagen, 1)
            pressed = True

        pygame.display.update()

        if pressed:
            screen.blit(fondo_imagen, [0, 0])
            boton_piedra.draw(screen)
            boton_papel.draw(screen)
            boton_tijera.draw(screen)
            boton_lagarto.draw(screen)
            boton_spock.draw(screen)
            screen.blit(imagen_espera, (345, 416))
            pygame.display.update()

            return seleccion

def menu_3partidas():
    time.sleep(0.2)
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_3partidas.png").convert()
    # BOTONES
    start_time = pygame.time.get_ticks()

    while True:
        current_time = pygame.time.get_ticks()
        if current_time - start_time > 2000:
            break
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        pygame.display.update()

def menu_resultado(nombre_jug1, nombre_jug2, seleccion_jug1, seleccion_jug2, resultado):
    time.sleep(0.2)
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/fondo_vacio.png").convert()
    boton_siguiente_imagen = pygame.image.load('imagenes/boton_next.png').convert_alpha()
    piedra_imagen = pygame.image.load('imagenes/boton_piedra.png').convert_alpha()
    papel_imagen = pygame.image.load('imagenes/boton_papel.png').convert_alpha()
    tijera_imagen = pygame.image.load('imagenes/boton_tijeras.png').convert_alpha()
    lagarto_imagen = pygame.image.load('imagenes/boton_lagarto.png').convert_alpha()
    spock_imagen = pygame.image.load('imagenes/boton_spock.png').convert_alpha()
    # BOTONES
    boton_siguiente = botones.boton(990, 393, boton_siguiente_imagen, 1)
    # SELECCIONES 1
    match seleccion_jug1:
        case 1:
            jugador1 = botones.boton(640, 281, piedra_imagen, 1)
        case 2:
            jugador1 = botones.boton(640, 281, papel_imagen, 1)
        case 3:
            jugador1 = botones.boton(640, 281, tijera_imagen, 1)
        case 4:
            jugador1 = botones.boton(640, 281, lagarto_imagen, 1)
        case 5:
            jugador1 = botones.boton(640, 281, spock_imagen, 1)
    # SELECCIONES 2
    match seleccion_jug2:
        case 1:
            jugador2 = botones.boton(640, 509, piedra_imagen, 1)
        case 2:
            jugador2 = botones.boton(640, 509, papel_imagen, 1)
        case 3:
            jugador2 = botones.boton(640, 509, tijera_imagen, 1)
        case 4:
            jugador2 = botones.boton(640, 509, lagarto_imagen, 1)
        case 5:
            jugador2 = botones.boton(640, 509, spock_imagen, 1)
    # TEXTO
    font = pygame.font.Font('imagenes/SigmarOne-Regular.ttf', 50)

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        if jugador1.draw(screen):
            continue
        if jugador2.draw(screen):
            continue
        if boton_siguiente.draw(screen):
            break

        if resultado == nombre_jug1:
            result = '¡Gana ' + nombre_jug1 + '!'
        elif resultado == 'empate':
            result = 'Empate :)'
        else:
            result = '¡Gana ' + nombre_jug2 + '!'

        texto_resultado = font.render(result, True, (0, 0, 0))
        texto_jugador1 = font.render(str(nombre_jug1), True, (0, 0, 0))
        texto_jugador2 = font.render(str(nombre_jug2), True, (0, 0, 0))
        texto_centrar = texto_resultado.get_rect(center=(1280 / 2, 117))
        screen.blit(texto_jugador1, (146, 315))
        screen.blit(texto_jugador2, (146, 543))
        screen.blit(texto_resultado, texto_centrar)
        pygame.display.flip()
        pygame.display.update()

def ganador_perdedor(resultado):
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/fondo_vacio.png").convert()
    boton_continuar_imagen = pygame.image.load('imagenes/boton_continuar.png').convert_alpha()
    imagen_ganador = pygame.image.load('imagenes/imagen_ganado.png').convert_alpha()
    imagen_perdedor = pygame.image.load('imagenes/imagen_perdido.png').convert_alpha()
    # BOTONES
    boton_continuar = botones.boton(467, 670, boton_continuar_imagen, 1)

    match resultado:
        case 1:
            imagen_resultado = botones.boton(391, 205, imagen_perdedor, 1)
        case 2:
            imagen_resultado = botones.boton(368, 204, imagen_ganador, 1)

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        if imagen_resultado.draw(screen):
            continue
        if boton_continuar.draw(screen):
            break
        pygame.display.update()

def menu_ranking():
    time.sleep(0.2)
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_ranking.png").convert()
    boton_salir_imagen = pygame.image.load('imagenes/boton_salir.png').convert_alpha()
    boton_volver_jugar_imagen = pygame.image.load("imagenes/boton_volver_jugar.png").convert_alpha()
    # BOTONES
    boton_salir = botones.boton(554, 690, boton_salir_imagen, 1)
    # BBDD
    conexion = sqlite3.connect('ranking.db')
    cursor = conexion.cursor()
    font = pygame.font.Font('imagenes/SigmarOne-Regular.ttf', 50)
    consulta = "SELECT Nombre FROM RANKING ORDER BY Victorias DESC LIMIT 4"
    cursor.execute(consulta)
    resultados = cursor.fetchall()
    conexion.close()

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        if boton_salir.draw(screen):
            raise SystemExit

        y = 270
        contador = int(1)
        for resultado in resultados:
            texto = font.render('{}. {}'.format(contador, *resultado), True, (0, 0, 0))
            texto_centrar = texto.get_rect(center=(1280 / 2, y))
            screen.blit(texto, texto_centrar)
            y += 100
            contador += 1
        pygame.display.update()

def menu_error(error):
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_error.png").convert()
    boton_salir_imagen = pygame.image.load('imagenes/boton_salir.png').convert_alpha()
    # BOTONES
    boton_salir = botones.boton(554, 670, boton_salir_imagen, 1)
    # TEXTO
    font = pygame.font.Font('imagenes/SigmarOne-Regular.ttf', 35)
    texto_error = font.render(f'Error: {error}', True, (255, 0, 0))
    texto_centrar = texto_error.get_rect(center=(1280 / 2, 523))

    while True:
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        if boton_salir.draw(screen):
            raise SystemExit
        screen.blit(texto_error, texto_centrar)
        pygame.display.update()

def menu_adios():
    time.sleep(0.2)
    # IMÁGENES
    fondo_imagen = pygame.image.load("imagenes/menu_adios.png").convert()
    # BOTONES
    start_time = pygame.time.get_ticks()

    while True:
        current_time = pygame.time.get_ticks()
        if current_time - start_time > 2000:
            break
        screen.blit(fondo_imagen, [0, 0])
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                raise SystemExit
        pygame.display.update()

