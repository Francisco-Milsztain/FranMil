import cv2                         # Manipular y editar imágenes y videos
import dlib                        # Detección de rostros y predicción de puntos faciales
import numpy as np                 # Manejo de matrices
from scipy.spatial import distance # Calcular distancias espaciales usando funciones (dentro del EAR)

# Se calcula el EAR (eye aspect ratio) para detectar si un ojo esta abierto o cerrado
# Esta funcion va a tener 6 parametros, todos siendo puntos de cada ojo (se llama 1 vez por ojo)
# Distance.euclidean calcula las distancias entre los puntos que se ingresen. [0, 1, 2, 3, 4, 5] son los puntos de cada ojo (6 puntos por cada ojo)
# Los puntos van a ser un conjunto de coordenadas [x, y]
def eye_aspect_ratio(ojo):
    A = distance.euclidean(ojo[1], ojo[5])
    B = distance.euclidean(ojo[2], ojo[4])
    C = distance.euclidean(ojo[0], ojo[3])
    return (A + B) / (2.0 * C) # Se devuelve el resultado del EAR

# Se establecen los 6 puntos faciales para cada ojo que utiliza el modelo de 68 puntos de dlib
# 00–16: contorno de la mandíbula
# 17–21: ceja derecha
# 22–26: ceja izquierda
# 27–30: puente de la nariz
# 30–35: parte inferior de la nariz
# 36–41: ojo derecho                    | = DER
# 42–47: ojo izquierdo                  | = IZQ
# 48–67: boca

DER = list(range(36, 42)) # [36, 37, 38, 39, 40, 41] son los puntos que luego se usan como [0, 1, 2, 3, 4, 5] en el EAR para el ojo derecho   (Luego de ser convertidos a [x, y])
IZQ = list(range(42, 48)) # [42, 43, 44, 45, 46, 47] son los puntos que luego se usan como [0, 1, 2, 3, 4, 5] en el EAR para el ojo izquierdo (Luego de ser convertidos a [x, y])

# Leer imagen
imagen = cv2.imread("imagendecara1.jpg") # Cambiar el numero final para seleccionar otra imagen (ejemplo: "imagendecara1.jpg", "imagendecara2.jpg")

#Convertir de GBR a RGB (No es necesario)
imagen_rgb = cv2.cvtColor(imagen, cv2.COLOR_BGR2RGB)
# Convertir a grises
grises = cv2.cvtColor(imagen_rgb, cv2.COLOR_RGB2GRAY)

# Cargar detector y predictor
detector = dlib.get_frontal_face_detector()                               # Detecta las caras en la imagen 
predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat") # Detecta y marca los 68 puntos de referencia 

# Detectar caras
caras = detector(grises) # Se detectan las caras (Se guardan en formato rectangular dlib.rectangle)

for numcara in caras: # Se hace para cada cara detectada

    shape = predictor(grises, numcara) # Se obtienen los 68 puntos (shape es un objeto que guarda los 68 puntos en formato dlib.point con atributos .x .y)
    
    puntos = [] # Se crea una lista vacia para guardar las coordenadas de cada punto
    for punto in shape.parts(): # shape.parts devuelve una lista con los 68 puntos, asi que lo que este dentro del for: se va a hacer para cada punto
        x = punto.x # Se guarda en x el atributo .x de cada punto
        y = punto.y # Se guarda en y el atributo .y de cada punto
        puntos.append([x, y]) # Se agregan [x, y] de cada punto a la lista puntos

    landmarks = np.array(puntos) # Se convierte la lista puntos en una matriz de valores (68 filas. Una(1) columna para x. Una(1) columna para y)
    # Se puede hacer print(puntos) o print(landmarks) para visualizar las coordenadas de cada punto


    # Asignacion ojos
    ojo_DER = landmarks[DER] # Se asignan a ojoDER los valores 36 a 41 de la matriz (lista ordenada) landmarks
    ojo_IZQ = landmarks[IZQ] # Se asignan a ojoIZQ los valores 42 a 47 de la matriz (lista ordenada) landmarks
    EAR_DER = eye_aspect_ratio(ojo_DER) # Se llama a la funcion eye_aspect_ratio con los valores de EAR_DER y con ojo siendo ojo_DER (para calcular EAR de ojo_DER)
    EAR_IZQ = eye_aspect_ratio(ojo_IZQ) # Se llama a la funcion eye_aspect_ratio con los valores de EAR_IZQ y con ojo siendo ojo_IZQ (para calcular EAR de ojo_IZQ)

    # Se imprimen los resultados del EAR de cada ojo
    print(f"EAR izquierda: {EAR_IZQ:.2f}") # Solo se imprimen los primeros 2 decimales
    print(f"EAR derecha: {EAR_DER:.2f}")   # Solo se imprimen los primeros 2 decimales

    # Determinar si los ojos están abiertos o cerrados con un umbral
    if (EAR_IZQ < 0.21 and EAR_DER < 0.21): # Si ambos EAR son menores a 0.21 (ojos cerrados)
        IZQ_ABIERTO = False
        DER_ABIERTO = False      
    if (EAR_IZQ > 0.21 and EAR_DER > 0.21): # Si ambos EAR son mayores a 0.21 (ojos abiertos)
        IZQ_ABIERTO = True
        DER_ABIERTO = True

    # Que pasa dependiendo del estado de los ojos
    if (IZQ_ABIERTO == False and DER_ABIERTO == False): # Si los dos ojos están cerrados, se dibujan los puntos en rojo
        valR = 255
        valG = 0
        valB = 0    
    if (IZQ_ABIERTO == True and DER_ABIERTO == True): # Si los dos ojos están abiertos, se dibujan los puntos en verde
        valR = 0
        valG = 255
        valB = 0
    

    # Dibujar puntos de los ojos en la imagen
    for (x, y) in ojo_IZQ: # Se repite para cada cojunto [x, y] dentro de ojo_IZQ
        cv2.circle(imagen, (x, y), 2, (valB, valG, valR), -1) # Se dibuja un punto en "imagen", en las coordenadas (x, y), con grosor 2, en formato BGR, con grosor de bordes -1

    for (x, y) in ojo_DER: # Se repite para cada cojunto [x, y] dentro de ojo_DER
        cv2.circle(imagen, (x, y), 2, (valB, valG, valR), -1) # Se dibuja un punto en "imagen", en las coordenadas (x, y), con grosor 2, en formato BGR, con grosor de bordes -1

# Mostrar la imagen
cv2.imshow("Indicador ojos", imagen)

print("Presione cualquier tecla para cerrar el programa")
cv2.waitKey(0)
cv2.destroyAllWindows()
