import cv2

# Cargar imagen
imagen = cv2.imread("imagendecara1.jpg") # Cambiar a "imagendecara2.jpg" para probar con la otra imagen
altura, anchura, BGR = imagen.shape
print(f"Dimensiones imagen. Ancho: {anchura} Alto: {altura}")
print("")

# Redimensionar si es necesario
max_dim = 1000

if altura > max_dim:
    print("Altura supera 1000")
nueva_altura = 1000

if anchura > max_dim:
    print("Anchura supera 1000")
nueva_anchura = 800

imagen = cv2.resize(imagen, (nueva_anchura, nueva_altura))
print(f"Imagen redimensionada a: {imagen.shape[1]}x{imagen.shape[0]}")


# Se convierten los colores de la imagen a una escala de grises
grises = cv2.cvtColor(imagen, cv2.COLOR_BGR2GRAY)

# Mostrar imagen en blanco y negro
cv2.imshow("Cara en gris", grises)

# Cargar el clasificador Haar de rostro y ojos
detector_cara = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")
detector_ojos = cv2.CascadeClassifier("haarcascade_eye.xml")

key = cv2.waitKey(0)
cv2.destroyAllWindows()
