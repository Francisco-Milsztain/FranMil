import cv2
import mediapipe as mp
import numpy as np
from scipy.spatial import distance
from picamera2 import Picamera2

def eye_aspect_ratio(ojo):
    A = distance.euclidean(ojo[1], ojo[5])
    B = distance.euclidean(ojo[2], ojo[4])
    C = distance.euclidean(ojo[0], ojo[3])
    return (A + B) / (2.0 * C)

DER = [33, 160, 158, 133, 153, 144]
IZQ = [362, 385, 387, 263, 373, 380]

mp_face_mesh = mp.solutions.face_mesh
face_mesh = mp_face_mesh.FaceMesh(static_image_mode=False, max_num_faces=1, refine_landmarks=True)

ojo_IZQ = []
ojo_DER = []
no_deteccion = 0
no_camaras = 0

IZQ_ABIERTO = False
DER_ABIERTO = False

picam2 = Picamera2()
config = picam2.create_preview_configuration(main={"size": (640, 480)})
picam2.configure(config)
picam2.start()

print()
print()
print("Programa Iniciado")
print("Presione la tecla 'x' para cerrar el reproductor")
print()
print()

while True:
    frame = picam2.capture_array()

    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = face_mesh.process(frame_rgb)

    color_IZQ = (255, 255, 255)
    color_DER = (255, 255, 255)

    if results.multi_face_landmarks:
        for face_landmarks in results.multi_face_landmarks:
            h, w, _ = frame.shape
            puntos = []
            for id, lm in enumerate(face_landmarks.landmark):
                x, y = int(lm.x * w), int(lm.y * h)
                puntos.append([x, y])
            landmarks = np.array(puntos)

            ojo_DER = landmarks[DER]
            ojo_IZQ = landmarks[IZQ]
            EAR_DER = eye_aspect_ratio(ojo_DER)
            EAR_IZQ = eye_aspect_ratio(ojo_IZQ)

            DER_ABIERTO = EAR_DER > 0.21
            IZQ_ABIERTO = EAR_IZQ > 0.21

            if DER_ABIERTO:
                color_DER = (0, 255, 0)  # Verde
            else:
                color_DER = (0, 0, 255)  # Rojo

            if IZQ_ABIERTO:
                color_IZQ = (0, 255, 0)  # Verde
            else:
                color_IZQ = (0, 0, 255)  # Rojo
    else:
        ojo_IZQ = []
        ojo_DER = []
        no_deteccion = no_deteccion + 1
        print(f"ERROR: no_deteccion.{no_deteccion}, No se detectan caras")

    for (x, y) in ojo_IZQ:
        cv2.circle(frame, (x, y), 2, color_IZQ, -1)
    for (x, y) in ojo_DER:
        cv2.circle(frame, (x, y), 2, color_DER, -1)

    cv2.imshow("Deteccion de Ojos", frame)

    if cv2.waitKey(1) & 0xFF == ord('x'):
        break

picam2.stop()
cv2.destroyAllWindows()
