import pygame


class boton():
    def __init__(self, x, y, imagen, escala):

        # Codigo para rescalar las imagenes y hacerlas mas pequeñas o mas grandes
        width = imagen.get_width()
        height = imagen.get_height()

        self.imagen = pygame.transform.scale(imagen, (int(width * escala), int(height * escala)))
        self.rect = self.imagen.get_rect()
        self.rect.topleft = (x, y)
        self.clicked = False

    def draw(self, superficie):
        action = False

        # Dibuja el boton en la pantalla
        superficie.blit(self.imagen, (self.rect.x, self.rect.y))

        # Obtener posicion del raton
        pos = pygame.mouse.get_pos()

        # Chequear posicion y clicado del raton sobre los botones
        if self.rect.collidepoint(pos):

            if pygame.mouse.get_pressed()[0] == 1 and self.clicked == False:
                self.clicked = True
                action = True

            if pygame.mouse.get_pressed()[0] == 0:
                self.clicked = False

        return action