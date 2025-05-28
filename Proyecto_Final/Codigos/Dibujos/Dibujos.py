import numpy as np
import cv2

# Se va a crear una matriz de valores con pixeles en negro que van a ser guardados en imagen
# La matriz va a tener 900x900 valores (pixeles). Cada pixel va a tener 3 canales, haciendola BGR (blue y red estan invertidos)
imagen = np.zeros((900, 900, 3), dtype = np.uint8)


    ### RECTANGULO BLANCO ###
# Se dibuja un rectángulo blanco desde (50,50) hasta (250,250) 
# El color del rectángulo va a ser blanco en RGB: (255,255,255)
imagen[
    50:400,  #Valores de Y: desde 50 hasta 100. (0,0) es arriba a la izquierda
    50:250,  #Valores de X: desde 50 hasta 250. (900,900) es abajo a la derecha 
    ] = [255, 255, 255] #RGB

    ### CIRCULO VERDE ###
cv2.circle(imagen, 
           (400, #Posición inicial de Y
            700, #Posición inicial de X
            ), 
            
            50,  #Radio 
            
            (0, 255, 0), #BGR (como G (verde) esta en 255 y el resto en 0, se va a hacer verde)
             
            -1) #0 = Linea externa; -1 = Relleno

    ### LINEA ROJA ###
cv2.line(imagen, 
         (60, #Posición inicial de Y
          200, #Posición inicial de X
          ), 
          
          (800, #Posición final de Y
           550, #Posición final de X
           ),
           
           (0, 0, 255), #BGR (como R (rojo) esta en 255 y el resto en 0, se va a hacer rojo)
            
            3) #Grosor de la linea

cv2.imshow("Dibujos", imagen)
cv2.waitKey(0)
cv2.destroyAllWindows()