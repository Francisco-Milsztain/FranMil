import cv2

# Cargar imagen
imagen = cv2.imread("imagendecara.jpg") # Cambiar a "imagendecara2.jpg" para probar con la otra imagen

# Se convierten los colores de la imagen a una escala de grises
grises = cv2.cvtColor(imagen, cv2.COLOR_BGR2GRAY)
# Mostrar imagen en blanco y negro
cv2.imshow("Cara en gris", grises)

# Cargar el clasificador Haar de rostro
detector_cara = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")

# Detectar rostros en la imagen. grises va a ser la imagen a analizar
# caras va a ser una lista de rectangulos que representan las regiones donde OpenCV detectó una cara
# cada rectangulo guardado en caras tiene 4 valores, que indican la posición y tamaño.
caras = detector_cara.detectMultiScale(grises, scaleFactor=1.3, minNeighbors=5) #detectMultiScale guarda los valores de las coordenadas que están alrededor de la cara


# Dibujar un recángulo alrededor de la cara detectada
for (x, y, w, h) in caras: # Se usa for para que se dibuje un rectángulo por cada conjunto de valores de la lista caras
    cv2.rectangle(imagen,         # En que archivo se dibuja
                  (x, y),         # Posición inicial de dibujado (para cada rectángulo)
                  (x + w, y + h), # Posición final de dibujado (para cada rectángulo)
                  (255, 0, 0),    # BGR
                  2)              # Escala

# Mostrar resultado de detección
cv2.imshow("Deteccion de cara", imagen)

while True: # Salir del programa
    tecla = cv2.waitKey(100)  # espera 100 ms
    print("Escribe 'SALIR' para cerrar el programa:")
    entrada = input()
    if entrada.strip().upper() == "SALIR": #.upper sirve para que el mensaje siempre se lea como si fuera en mayusculas
        break
