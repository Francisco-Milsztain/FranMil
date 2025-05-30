import cv2

# Cargar imagen
imagen = cv2.imread("imagendecara1.jpg") # Cambiar a "imagendecaraX.jpg" para probar con otras imagenes
altura, anchura, BGR = imagen.shape
print("Dimensiones imagen:")
print(f"Ancho: {anchura} Alto: {altura}")
print("")

# Se convierten los colores de la imagen a una escala de grises
grises = cv2.cvtColor(imagen, cv2.COLOR_BGR2GRAY)

# Cargar el clasificador Haar de rostro y ojos
detector_cara = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")
detector_ojos = cv2.CascadeClassifier("haarcascade_eye.xml")

# Detectar rostros en la imagen. grises va a ser la imagen a analizar
# caras va a ser una lista de rectangulos que representan las regiones donde OpenCV detectó una cara
# cada rectangulo guardado en caras tiene 4 valores, que indican la posición y tamaño.
caras = detector_cara.detectMultiScale(grises, scaleFactor = 1.3, minNeighbors = 5) #detectMultiScale guarda los valores de las coordenadas que están alrededor de la cara

    ### DIBUJO ALREDEDOR DE CARA ###
# Recángulo azul alrededor de la cara detectada
for (x, y, w, h) in caras: # Se usa for para que se dibuje un rectángulo por cada conjunto de valores de la lista caras
    print("Se detectó un rostro en")
    print(f"/INICIO/ X: {x} Y: {y}")        # Se imprimen las coordenadas iniciales de la cara
    print(f"/FINAL/ X: {x + w} Y: {y + h}") # Se imprimen las coordenadas finales de la cara
    print("")

    cv2.rectangle(imagen,         # En que archivo se dibuja
                  (x, y),         # Posición inicial de dibujado (para cada rectángulo)
                  (x + w, y + h), # Posición final de dibujado (para cada rectángulo)
                  (255, 0, 0),    # BGR
                  2)              # Escala
    
print("----------")
print("")

# Recortar región de interés (ROI [Region Of Interest]) para los ojos
cara_gris = grises[y:y + h, x:x + w]  # Se extrae la parte de la imagen (grises) en la que hay una cara

# Detectar ojos dentro de la ROI (dentro de la cara)
ojos = detector_ojos.detectMultiScale(cara_gris, scaleFactor=1.1, minNeighbors=10) # Se guardan los valores donde se detectaron los ojos

    ### DIBUJO ALREDEDOR DE OJOS ###
# Rectángulo verde para cada ojo dentro de la cara
for (ox, oy, ow, oh) in ojos: # Se usa for para que se dibuje un rectángulo por cada conjunto de valores de la lista ojos
    print("Se detecto un ojo en ")
    print(f"/INICIO/ X: {x + ox} Y: {y + oy}")          # Se imprimen las coordenadas iniciales de los ojos
    print(f"/FINAL/ X: {x + ox + ow} Y: {y + oy + oh}") # Se imprimen las coordenadas finales de los ojos
    print("")

    cv2.rectangle(imagen,                     # En que archivo se dibuja
                  (x + ox, y + oy),           # Posición inicial de dibujado (para cada rectángulo)
                  (x + ox + ow, y + oy + oh), # Posición final de dibujado (para cada rectángulo)
                  (0, 255, 0),                # BGR 
                  2)                          # Escala

print("----------")
print("")

# Mostrar imagen en blanco y negro
cv2.imshow("Cara en gris", grises)
# Mostrar resultado de detección
cv2.namedWindow("Cara y ojos detectados", cv2.WINDOW_NORMAL)
cv2.imshow("Cara y ojos detectados", imagen)

print("Presione 'p' para ingresar coordenadas del píxel a editar.")
print("Presione ESC para salir")
print("")
while True: # RESPUESTAS A INPUTS
    cv2.imshow("Cara y ojos detectados", imagen)
    key = cv2.waitKey(0)

    if key == ord('p'): # Si la tecla es p se piden las coordenadas
        # Pedir coordenadas al usuario
        ingresox = int(input("Ingresa la coordenada X del píxel: "))
        ingresoy = int(input("Ingresa la coordenada Y del píxel: "))
        print("")

        # Dibujar en la imagen principal
        cv2.rectangle(imagen,
                      (ingresox, ingresoy),
                      (ingresox + 1, ingresoy + 1),
                      (0, 0, 255),
                      2)

    elif key == 27:  # Si la tecla es esc se cierra el programa
        cv2.destroyAllWindows()
        break
