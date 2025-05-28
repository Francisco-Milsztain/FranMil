import cv2

# Cargar la imagen
imagen = cv2.imread("ejemplo1.jpg")

# Mostrar la imagen
cv2.imshow("Imagen", imagen)

print('Presiona P para seleccionar un pixel')
while True:
    key = cv2.waitKey(0) # Se espera infinitamente hasta que una tecla sea presionada, esta tecla se iguala a key

    if key == ord('p'):
        break # En caso de que la tecla presionada no haya sido 'x', se vuelve al prinicipio el while


# Obtener dimensiones de la imagen y enviarlas
valoresY, valoresX, _ = imagen.shape
print("Tamaño de imagen")
print(f"ancho: {valoresX}, alto: {valoresY}")

# Pedir coordenadas al usuario usando input()
x = int(input("Ingresa la coordenada X del píxel: "))
y = int(input("Ingresa la coordenada Y del píxel: "))

# Validar si están dentro del rango
if 0 <= x < valoresX and 0 <= y < valoresY: # Si x esta dentro de valoresX e y esta dentro de valoresY
    pixel = imagen[y, x]                    # A pixel se le dan los valores de las coordenadas elegidas
    B, G, R = pixel
    print(f"Color del píxel en ({x}, {y}):")
    print(f"BGR = {B}, {G}, {R}")

    # Se dibuja una linea aputando al pixel que se seleccionó
    cv2.line(imagen, 
            (x, y),    # Punto inicial
            (x, y),    # Punto final
            (0, 0, 0), # Color negro
            3)         # Grosor

# Actualizar la imagen ahora con la linea   
cv2.imshow("Imagen", imagen)


cv2.waitKey(0)
cv2.destroyAllWindows()