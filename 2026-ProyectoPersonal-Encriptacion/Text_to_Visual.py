#Este programa tiene 2 modos: 
#"Modo encriptación" (Emode):    El usuario escribe un texto de no más de 500 caracteres, y el código convierte el texto ingresado a una imagen .png en blanco y negro
#"Modo desencriptación" (Dmode): El usuario ingresa el nombre del archivo .png ya encriptado que desee leer, y el programa devuelve el texto que se encontraba encriptado.

import cv2
import numpy as np

def Encryption_Function(USERINPUT, ENCRYPTION):

    incorrectEncryption = False

    characterList = [
        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z', 'ñ', '',
        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z', 'Ñ', ' ', 
        '.', ',',  
        ]

    invalidCharacters = []

    Encode_space = [0, 0, 0, 0, 0]
    Encode_a = [0, 0, 0, 0, 1]
    Encode_b = [0, 0, 0, 1, 0]
    Encode_c = [0, 0, 0, 1, 1]
    Encode_d = [0, 0, 1, 0, 0]
    Encode_e = [0, 0, 1, 0, 1]
    Encode_f = [0, 0, 1, 1, 0]
    Encode_g = [0, 0, 1, 1, 1]
    Encode_h = [0, 1, 0, 0, 0]
    Encode_i = [0, 1, 0, 0, 1]
    Encode_j = [0, 1, 0, 1, 0]
    Encode_k = [0, 1, 0, 1, 1]
    Encode_l = [0, 1, 1, 0, 0]
    Encode_m = [0, 1, 1, 0, 1]
    Encode_n = [0, 1, 1, 1, 0]
    Encode_o = [0, 1, 1, 1, 1]
    Encode_p = [1, 0, 0, 0, 0]
    Encode_q = [1, 0, 0, 0, 1]
    Encode_r = [1, 0, 0, 1, 0]
    Encode_s = [1, 0, 0, 1, 1]
    Encode_t = [1, 0, 1, 0, 0]
    Encode_u = [1, 0, 1, 0, 1]
    Encode_v = [1, 0, 1, 1, 0]
    Encode_w = [1, 0, 1, 1, 1]
    Encode_x = [1, 1, 0, 0, 0]
    Encode_y = [1, 1, 0, 0, 1]
    Encode_z = [1, 1, 0, 1, 0]
    Encode_dot = [1, 1, 1, 0, 0]
    Encode_comma = [1, 1, 1, 0, 1]
    Encode_ñ = [1, 1, 1, 1, 0]

    for letter in USERINPUT:
        if letter in characterList:
            if letter == 'a' or letter == 'A':
                ENCRYPTION.append(Encode_a)
            if letter == 'b' or letter == 'B':
                ENCRYPTION.append(Encode_b)
            if letter == 'c' or letter == 'C':
                ENCRYPTION.append(Encode_c)
            if letter == 'd' or letter == 'D':
                ENCRYPTION.append(Encode_d)
            if letter == 'e' or letter == 'E':
                ENCRYPTION.append(Encode_e)
            if letter == 'f' or letter == 'F':
                ENCRYPTION.append(Encode_f)
            if letter == 'g' or letter == 'G':
                ENCRYPTION.append(Encode_g)
            if letter == 'h' or letter == 'H':
                ENCRYPTION.append(Encode_h)
            if letter == 'i' or letter == 'I':
                ENCRYPTION.append(Encode_i)
            if letter == 'j' or letter == 'J':
                ENCRYPTION.append(Encode_j)
            if letter == 'k' or letter == 'K':
                ENCRYPTION.append(Encode_k)
            if letter == 'l' or letter == 'L':
                ENCRYPTION.append(Encode_l)
            if letter == 'm' or letter == 'M':
                ENCRYPTION.append(Encode_m)
            if letter == 'n' or letter == 'N':
                ENCRYPTION.append(Encode_n)
            if letter == 'o' or letter == 'O':
                ENCRYPTION.append(Encode_o)
            if letter == 'p' or letter == 'P':
                ENCRYPTION.append(Encode_p)
            if letter == 'q' or letter == 'Q':
                ENCRYPTION.append(Encode_q)
            if letter == 'r' or letter == 'R':
                ENCRYPTION.append(Encode_r)
            if letter == 's' or letter == 'S':
                ENCRYPTION.append(Encode_s)
            if letter == 't' or letter == 'T':
                ENCRYPTION.append(Encode_t)
            if letter == 'u' or letter == 'U':
                ENCRYPTION.append(Encode_u)
            if letter == 'v' or letter == 'V':
                ENCRYPTION.append(Encode_v)
            if letter == 'w' or letter == 'W':
                ENCRYPTION.append(Encode_w)
            if letter == 'x' or letter == 'X':
                ENCRYPTION.append(Encode_x)
            if letter == 'y' or letter == 'Y':
                ENCRYPTION.append(Encode_y)
            if letter == 'z' or letter == 'Z':
                ENCRYPTION.append(Encode_z)
            if letter == 'ñ' or letter == 'Ñ':
                ENCRYPTION.append(Encode_ñ)
            if letter == '' or letter == ' ':
                ENCRYPTION.append(Encode_space)
            if letter == '.':
                ENCRYPTION.append(Encode_dot)
            if letter == ',':
                ENCRYPTION.append(Encode_comma)
        
        if letter not in characterList:
            incorrectEncryption = True
            invalidCharacters.append(letter)

            ENCRYPTION.append(Encode_space)

    return ENCRYPTION, incorrectEncryption, invalidCharacters

def Encryption2Visual_Function(ENCRYPTION, imagen, Xsize, Psize):

    size = Psize

    char = 1
    black = (0, 0, 0)
    white = (255, 255, 255)
    
    cordX1 = 0
    cordX2 = cordX1 + size
    
    cordY1 = 0
    cordY2 = cordY1 + size

    for place in ENCRYPTION:
        n0 = place[0]
        n1 = place[1]
        n2 = place[2]
        n3 = place[3]
        n4 = place[4]

        print('')
        print('Character number:', char, 'Binary code: ')
        print(n0)
        print(n1)
        print(n2)
        print(n3)
        print(n4)
        print('')

        char = char + 1

        #Numero 0
        if n0 == 0:
            color = black
        if n0 == 1:
            color = white

        imagen[cordY1:cordY2, cordX1:cordX2] = color
        cordX1 = cordX1 + size
        cordX2 = cordX2 + size

        #Numero 1
        if n1 == 0:
            color = black
        if n1 == 1:
            color = white

        imagen[cordY1:cordY2, cordX1:cordX2] = color
        cordX1 = cordX1 + size
        cordX2 = cordX2 + size

        #Numero 2
        if n2 == 0:
            color = black
        if n2 == 1:
            color = white

        imagen[cordY1:cordY2, cordX1:cordX2] = color
        cordX1 = cordX1 + size
        cordX2 = cordX2 + size

        #Numero 3
        if n3 == 0:
            color = black
        if n3 == 1:
            color = white

        imagen[cordY1:cordY2, cordX1:cordX2] = color
        cordX1 = cordX1 + size
        cordX2 = cordX2 + size

        #Numero 4
        if n4 == 0:
            color = black
        if n4 == 1:
            color = white

        imagen[cordY1:cordY2, cordX1:cordX2] = color
        cordX1 = cordX1 + size
        cordX2 = cordX2 + size

        if cordX2 >= Xsize:
            cordX1 = 0
            cordX2 = cordX1 + size

            cordY1 = cordY1 + size
            cordY2 = cordY1 + size

    return imagen

def Visual2Decryption_Function(LecturaImagen, VISUAL_DECRYPTION, Xsize, Ysize, Psize):
    
    size = Psize
    
    black = (0, 0, 0)
    white = (255, 255, 255)

    cordX = int(size/2)
    cordY = int(size/2)
    
    while cordY <= Ysize:
        char = []

        #Numero 0
        pixel = LecturaImagen[cordY, cordX]
        B, G, R = pixel
        color = (B, G, R)
        
        if color == black:
            n0 = 0
        if color == white:
            n0 = 1

        char.append(n0)    
        cordX = cordX + size
        
        #Numero 1
        pixel = LecturaImagen[cordY, cordX]
        B, G, R = pixel
        color = (B, G, R)
        
        if color == black:
            n1 = 0
        if color == white:
            n1 = 1

        char.append(n1)
        cordX = cordX + size

        #Numero 2
        pixel = LecturaImagen[cordY, cordX]
        B, G, R = pixel
        color = (B, G, R)
        
        if color == black:
            n2 = 0
        if color == white:
            n2 = 1

        char.append(n2)
        cordX = cordX + size

        #Numero 3
        pixel = LecturaImagen[cordY, cordX]
        B, G, R = pixel
        color = (B, G, R)
        
        if color == black:
            n3 = 0
        if color == white:
            n3 = 1

        char.append(n3)
        cordX = cordX + size

        #Numero 4
        pixel = LecturaImagen[cordY, cordX]
        B, G, R = pixel
        color = (B, G, R)
        
        if color == black:
            n4 = 0
        if color == white:
            n4 = 1

        char.append(n4)
        cordX = cordX + size

        VISUAL_DECRYPTION.append(char)

        if cordX >= Xsize:
            cordX = int(size/2)
            cordY = cordY + size

    return VISUAL_DECRYPTION

def Decryption_Function(VISUAL_DECRYPTION, DECRYPTION):
    Decode_space = [0, 0, 0, 0, 0]
    Decode_a = [0, 0, 0, 0, 1]
    Decode_b = [0, 0, 0, 1, 0]
    Decode_c = [0, 0, 0, 1, 1]
    Decode_d = [0, 0, 1, 0, 0]
    Decode_e = [0, 0, 1, 0, 1]
    Decode_f = [0, 0, 1, 1, 0]
    Decode_g = [0, 0, 1, 1, 1]
    Decode_h = [0, 1, 0, 0, 0]
    Decode_i = [0, 1, 0, 0, 1]
    Decode_j = [0, 1, 0, 1, 0]
    Decode_k = [0, 1, 0, 1, 1]
    Decode_l = [0, 1, 1, 0, 0]
    Decode_m = [0, 1, 1, 0, 1]
    Decode_n = [0, 1, 1, 1, 0]
    Decode_o = [0, 1, 1, 1, 1]
    Decode_p = [1, 0, 0, 0, 0]
    Decode_q = [1, 0, 0, 0, 1]
    Decode_r = [1, 0, 0, 1, 0]
    Decode_s = [1, 0, 0, 1, 1]
    Decode_t = [1, 0, 1, 0, 0]
    Decode_u = [1, 0, 1, 0, 1]
    Decode_v = [1, 0, 1, 1, 0]
    Decode_w = [1, 0, 1, 1, 1]
    Decode_x = [1, 1, 0, 0, 0]
    Decode_y = [1, 1, 0, 0, 1]
    Decode_z = [1, 1, 0, 1, 0]
    Decode_dot = [1, 1, 1, 0, 0]
    Decode_comma = [1, 1, 1, 0, 1]
    Decode_ñ = [1, 1, 1, 1, 0]
    
    for binary in VISUAL_DECRYPTION:
        if binary == Decode_a:
            DECRYPTION.append('a')
        if binary == Decode_b:
            DECRYPTION.append('b')
        if binary == Decode_c:
            DECRYPTION.append('c')
        if binary == Decode_d:
            DECRYPTION.append('d')
        if binary == Decode_e:
            DECRYPTION.append('e')
        if binary == Decode_f:
            DECRYPTION.append('f')
        if binary == Decode_g:
            DECRYPTION.append('g')
        if binary == Decode_h:
            DECRYPTION.append('h')
        if binary == Decode_i:
            DECRYPTION.append('i')
        if binary == Decode_j:
            DECRYPTION.append('j')
        if binary == Decode_k:
            DECRYPTION.append('k')
        if binary == Decode_l:
            DECRYPTION.append('l')
        if binary == Decode_m:
            DECRYPTION.append('m')
        if binary == Decode_n:
            DECRYPTION.append('n')
        if binary == Decode_o:
            DECRYPTION.append('o')
        if binary == Decode_p:
            DECRYPTION.append('p')
        if binary == Decode_q:
            DECRYPTION.append('q')
        if binary == Decode_r:
            DECRYPTION.append('r')
        if binary == Decode_s:
            DECRYPTION.append('s')
        if binary == Decode_t:
            DECRYPTION.append('t')
        if binary == Decode_u:
            DECRYPTION.append('u')
        if binary == Decode_v:
            DECRYPTION.append('v')
        if binary == Decode_w:
            DECRYPTION.append('w')
        if binary == Decode_x:
            DECRYPTION.append('x')
        if binary == Decode_y:
            DECRYPTION.append('y')
        if binary == Decode_z:
            DECRYPTION.append('z')
        if binary == Decode_ñ:
            DECRYPTION.append('ñ')
        if binary == Decode_space:
            DECRYPTION.append(' ')
        if binary == Decode_dot:
            DECRYPTION.append('.')
        if binary == Decode_comma:
            DECRYPTION.append(',')
        
    return ENCRYPTION


#imagen[Y1:Y2, X1:X2] = (B, G, R)

#(0, 0)     es arriba a la izquierda
#(500, 500) es abajo a la derecha

# Colores en BGR
black = (0, 0, 0)
white = (255, 255, 255)

Xsize = 500
Ysize = Xsize
Psize = 10

imagen = np.zeros((Ysize, Xsize, 3), dtype=np.uint8)
                   #Y     #X     #BGR


# COMIENZO DEL LOOP #
x = 1
while x == 1:
    print('')
    print('--- PROGRAM STARTED ---')

    USERINPUT = []
    ModeSelected = ''
    selectedMode = ''

    ENCRYPTION = []
    DECRYPTION = []

    VISUAL_DECRYPTION = []

    print('Select the mode you want to use by entering: "EncryptionMode" or "DecryptionMode" ("emode" or "dmode" for short).')

    ModeSelected = input('Mode: ')

    if (ModeSelected.lower() == 'encryptionmode' or ModeSelected.lower() == 'emode' or ModeSelected.lower() == 'e'):
        selectedMode = 'Encryption'
    elif (ModeSelected.lower() == 'decryptionmode' or ModeSelected.lower() == 'dmode' or ModeSelected.lower() == 'd'):
        selectedMode = 'Decryption'
    else:
        selectedMode = 'None'
        print('Mode not found.')
        print('')
        input('Press Enter to exit.')
        break

    print('Mode selected:', selectedMode)
    print('')
    

    # ENCRYPTION #

    if selectedMode == 'Encryption':

        # TEXTS IN BINARY #

        print('Enter string, of 500 characters MAX.')
        USERINPUT = input()
        print('')

        imagen[0:Ysize, 0:Xsize] = black

        ENCRYPTION, incorrectEncryption, invalidCharacters = Encryption_Function(USERINPUT, ENCRYPTION)
        print('Text in binary:')
        print(ENCRYPTION)

        # BINARY TO Visual ENCRYPTION #

        Encryption2Visual_Function(ENCRYPTION, imagen, Xsize, Psize)

        print('Enter the name of the image to save.')
        SavedImageName = input()

        if SavedImageName.endswith('.png'):
            cv2.imwrite(SavedImageName, imagen)
            print('The imagen has been saved to your decive under the name:', SavedImageName)
        else:
            SavedImageName = SavedImageName + '.png'
            cv2.imwrite(SavedImageName, imagen)
            print('The imagen has been saved to your decive under the name:', SavedImageName)

        if incorrectEncryption == True:
            print('')
            print('The string contains characters which can not be encrypted. Only use letters and spaces.')
            print('Invalid characters in your string:', ''.join(invalidCharacters))
            print('The text was encrypted successfully, but the invalid characters have been turned into spaces.')

        print('')
        print('Press anything to continue')
        cv2.imshow(SavedImageName, imagen)
        cv2.waitKey(0)
        cv2.destroyAllWindows()


    # DECRYPTION #

    if selectedMode == 'Decryption':
        print('Enter the name of the image to decrypt. Make sure it is a [.png] archive.')
        selectedImage = input()
        print('')

        if selectedImage.endswith('.png'):
            LecturaImagen = cv2.imread(selectedImage)
        else:
            selectedImage = selectedImage + '.png'
            LecturaImagen = cv2.imread(selectedImage)

        Ysize, Xsize, _ = LecturaImagen.shape
        Visual2Decryption_Function(LecturaImagen, VISUAL_DECRYPTION, Xsize, Ysize, Psize)

        print("Visual to binary:")
        print(VISUAL_DECRYPTION)
        print('')

        Decryption_Function(VISUAL_DECRYPTION, DECRYPTION)
        print('Decrypted string:')
        print(''.join(DECRYPTION))


    # PROGRAM TERMINATION #

    print('')
    print('Press ENTER to restart or input x to exit.')
    end = input('').lower()
    if (end == 'x'):
        x = 2