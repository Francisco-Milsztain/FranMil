import cv2
import numpy as np

# Cargar la imagen
img = cv2.imread("ejemplo1.jpg") #Se iguala a img a la lectura de la matriz de "ejemplo1.jpg"

# Invertir los colores usando NumPy
inversa = 255 - img #Se iguala a inversa el resultado de 255 - img ; lo que resulta en que se inviertan todos los pixeles de la imagen

# Mostrar la imagen original e invertida
cv2.imshow("Original", img)      #Se abre una ventana con la imagen original
cv2.imshow("Invertida", inversa) #Se abre una ventana con la imagen inversa

# Lo de abajo sirve para que al tocar cualquier tecla se cierre el programa (se puede eliminar)
cv2.waitKey(0)
cv2.destroyAllWindows()
