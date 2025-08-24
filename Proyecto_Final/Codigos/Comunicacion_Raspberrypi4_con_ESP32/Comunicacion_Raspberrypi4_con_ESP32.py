import cv2
import mediapipe as mp
import numpy as np
import time
import RPi.GPIO as GPIO
from scipy.spatial import distance
from picamera2 import Picamera2

# Funcion para determinar EAR (Distancias entre los puntos de los ojos)
def eye_aspect_ratio(ojo):
    A = distance.euclidean(ojo[1], ojo[5])
    B = distance.euclidean(ojo[2], ojo[4])
    C = distance.euclidean(ojo[0], ojo[3])
    return (A + B) / (2.0 * C)

# Funcion para determinar si la persona mantiene los ojos cerrados
def PersonaDormida(TiempoActual, SumaTiempo):
    return TiempoActual >= SumaTiempo

IZQ = [362, 385, 387, 263, 373, 380]
DER = [33, 160, 158, 133, 153, 144]

mp_face_mesh = mp.solutions.face_mesh
face_mesh = mp_face_mesh.FaceMesh(static_image_mode=False, max_num_faces=1, refine_landmarks=True)

ojo_IZQ = []
ojo_DER = []
no_deteccion = 0

IZQ_ABIERTO = False
DER_ABIERTO = False
OjosCerrados = False

TiempoActual = 0
SumaTiempo = 0

PIN_ALARMA = 10 # CAMBIAR ESTE POR EL PIN DEL RASPBERRY CONECTADO AL DEL ESP32
GPIO.setmode(GPIO.BCM)
GPIO.setup(PIN_ALARMA, GPIO.OUT)
GPIO.output(PIN_ALARMA, GPIO.LOW)

picam2 = Picamera2()
config = picam2.create_preview_configuration(main={"size": (640, 480)})
picam2.configure(config)
picam2.start()

print()
print("Programa Iniciado")
print("Presione la tecla 'x' para cerrar el reproductor")
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

            ojo_IZQ = landmarks[IZQ]
            ojo_DER = landmarks[DER]
            EAR_IZQ = eye_aspect_ratio(ojo_IZQ)
            EAR_DER = eye_aspect_ratio(ojo_DER)

            if EAR_IZQ > 0.21:
                IZQ_ABIERTO = True
            else:
                IZQ_ABIERTO = False
            if EAR_DER > 0.21:
                DER_ABIERTO = True
            else:
                DER_ABIERTO = False

            if IZQ_ABIERTO == True:
                color_IZQ = (0, 255, 0)  # Verde
            else:
                color_IZQ = (0, 0, 255)  # Rojo
            if DER_ABIERTO == True:
                color_DER = (0, 255, 0)  # Verde
            else:
                color_DER = (0, 0, 255)  # Rojo
    
    else:
        ojo_IZQ = []
        ojo_DER = []
        no_deteccion = no_deteccion + 1
        print(f"ERROR: no_deteccion.{no_deteccion}, No se detectan caras")

    # Determinar si la persona está dormida
    TiempoActual = time.time()

    if IZQ_ABIERTO == False and DER_ABIERTO == False and OjosCerrados == False:
        OjosCerrados = True
        print("| Iniciando cuenta regresiva (4s) |")
        SumaTiempo = TiempoActual + 4

    if IZQ_ABIERTO == False and DER_ABIERTO == False:
        if PersonaDormida(TiempoActual, SumaTiempo):
            print("ALERTA: PERSONA DORMIDA")
            GPIO.output(PIN_ALARMA, GPIO.HIGH) # Enviar señal al ESP32

    if IZQ_ABIERTO == True or DER_ABIERTO == True:
        OjosCerrados = False
        SumaTiempo = TiempoActual
        print("| Cuenta regresiva cancelada |")
        GPIO.output(PIN_ALARMA, GPIO.LOW)

    # Dibujo de los circulos
    for (x, y) in ojo_IZQ:
        cv2.circle(frame, (x, y), 2, color_IZQ, -1)
    for (x, y) in ojo_DER:
        cv2.circle(frame, (x, y), 2, color_DER, -1)

    cv2.imshow("Deteccion de Ojos", frame)

    if cv2.waitKey(1) & 0xFF == ord('x'):
        break

GPIO.cleanup()
picam2.stop()
cv2.destroyAllWindows()