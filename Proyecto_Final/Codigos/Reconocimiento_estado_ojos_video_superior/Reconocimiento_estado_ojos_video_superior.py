import cv2
import mediapipe as mp
import numpy as np
from scipy.spatial import distance

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

IZQ_ABIERTO = False
DER_ABIERTO = False

video = cv2.VideoCapture("videodecara2.mp4")

print()
print()
print("Programa Iniciado")
print("Presione la tecla 'x' para cerrar el reproductor")
print()
print()

fps = video.get(cv2.CAP_PROP_FPS)
frame_delay = int(1000 / fps)

while True:
    ret, frame = video.read()
    if not ret:
        print("Video finalizado")
        print("Presiona la tecla 'x' para salir")
        imagen_negro = np.zeros((600, 600, 3), dtype=np.uint8)
        while True:
            cv2.imshow("Deteccion de Ojos", imagen_negro)
            if cv2.waitKey(1) & 0xFF == ord('x'):
                break
        break

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
        no_deteccion += 1
        print(f"ERROR: no_deteccion.{no_deteccion}, No se detectan caras")

    for (x, y) in ojo_IZQ:
        cv2.circle(frame, (x, y), 2, color_IZQ, -1)
    for (x, y) in ojo_DER:
        cv2.circle(frame, (x, y), 2, color_DER, -1)

    cv2.imshow("Deteccion de Ojos", frame)

    if cv2.waitKey(frame_delay) & 0xFF == ord('x'):
        break

video.release()
cv2.destroyAllWindows()
