import cv2
import numpy as np

# Cargar la imagen
imagen = cv2.imread("ejemplo1.jpg") # Se iguala a img a la lectura de la matriz de "ejemplo1.jpg"

    ### CIRCULO VERDE ###
cv2.circle(imagen, 
           (150, #Posición inicial de Y
            150, #Posición inicial de X
            ), 
            
            150,  #Radio 
            
            (0, 255, 0), #BGR (como G (verde) esta en 255 y el resto en 0, se va a hacer verde)
             
            -1) #0 = Linea externa; -1 = Relleno

cv2.imshow("Imagen con figuras", imagen)
cv2.waitKey(0)
cv2.destroyAllWindows()