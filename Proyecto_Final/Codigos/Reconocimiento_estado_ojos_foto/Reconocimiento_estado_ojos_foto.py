import cv2
import dlib
import numpy as np
from scipy.spatial import distance

# EAR
def eye_aspect_ratio(eye):
    A = distance.euclidean(eye[1], eye[5])
    B = distance.euclidean(eye[2], eye[4])
    C = distance.euclidean(eye[0], eye[3])
    return (A + B) / (2.0 * C)

# Índices de los ojos
LEFT = list(range(42, 48))
RIGHT = list(range(36, 42))

# Leer imagen
image_bgr = cv2.imread("imagendecara4.jpg", cv2.IMREAD_COLOR)
if image_bgr is None:
    print("No se pudo cargar la imagen.")
    input("Presiona ENTER para salir")
    exit()

# Convertir a RGB
image_rgb = cv2.cvtColor(image_bgr, cv2.COLOR_BGR2RGB)

# Verificar tipo de imagen
print(f"Tipo: {type(image_rgb)}, dtype: {image_rgb.dtype}, shape: {image_rgb.shape}")
if image_rgb.dtype != np.uint8 or image_rgb.shape[2] != 3:
    print("Imagen no válida para dlib.")
    input("Presioná ENTER para salir")
    exit()

# Cargar detector y predictor
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")

# Detectar rostros
try:
    faces = detector(image_rgb)
except RuntimeError as e:
    print("Error detectando rostros:", e)
    input("Presioná ENTER para salir")
    exit()

for face in faces:
    shape = predictor(image_rgb, face)
    landmarks = np.array([[p.x, p.y] for p in shape.parts()])

    # Ojos
    left_eye = landmarks[LEFT]
    right_eye = landmarks[RIGHT]

    ear_left = eye_aspect_ratio(left_eye)
    ear_right = eye_aspect_ratio(right_eye)

    print(f"EAR izquierda: {ear_left:.2f}, EAR derecha: {ear_right:.2f}")

    # Dibujar contorno de los ojos en la imagen BGR (para mostrar)
    for (x, y) in left_eye:
        cv2.circle(image_bgr, (x, y), 2, (0, 255, 0), -1)
    for (x, y) in right_eye:
        cv2.circle(image_bgr, (x, y), 2, (0, 255, 0), -1)

# Mostrar la imagen
cv2.imshow("Marcar ojos", image_bgr)
cv2.waitKey(0)
cv2.destroyAllWindows()

input("Presione ENTER para cerrar el programa")
