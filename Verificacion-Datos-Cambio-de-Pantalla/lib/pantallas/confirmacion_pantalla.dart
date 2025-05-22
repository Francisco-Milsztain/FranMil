import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Confirmacion extends StatefulWidget {

  final String nombrecorrecto;   //Cual es el nombre que debe ser ingresado (se recibe desde inicio)
  final String apellidocorrecto; //Cual es el apellido que debe ser ingresado (se recibe desde inicio)

  Confirmacion({super.key, //Variables que van a ser recibidas
  required this.nombrecorrecto, 
  required this.apellidocorrecto,
  
  });

  @override
  State<Confirmacion> createState() => _ConfirmacionState();
}

class _ConfirmacionState extends State<Confirmacion> {

  //VARIABLES
  TextEditingController nombreingresado = TextEditingController();   //Establece a "nombreingresado" como controlador de texto (lee lo que se escribe en "nombreingresado")
  TextEditingController apellidoingresado = TextEditingController(); //Establece a "apellidoingresado" como controlador de texto (lee lo que se escribe en "apellidoingresado")
  String confirmacionnombre = 'Esperando Nombre';     //Indica si el nombre ingresado fue correcto
  String confirmacionapellido = 'Esperando Apellido'; //Indica si el apellido ingresado fue correcto
  
  String nombre = '';
  String apellido = '';

  String apellidomostrar = ''; //Muestra el apellido que se ingreso

  Color colornombre = Colors.black;
  Color colorapellido = Colors.black;

  bool ocultar = true; //Determina si el apellido es mostrado u ocultado

  void ingreso(){ //Corroboracion de los datos ingresados
    setState(() {
      nombre = nombreingresado.text;     //Se asigna lo que se recibio en "nombreingresado" a la variable "nombre"
      apellido = apellidoingresado.text; //Se asigna lo que se recibio en "apellidoingresado" a la variable "apellido"

      if (ocultar == false){ //Si "ocultar" == false, osea que el apellido puede ser mostrado:
        apellidomostrar = apellidoingresado.text; //Se asigna lo que se recibio en "apellidoingresado" a la variable "apellidomostrar"
      }
      if (ocultar == true){ //Si "ocultar" == true, osea que el apellido NO puede ser mostrado:
        apellidomostrar = 'Apellido oculto';
      }

      //Se determina si el nombre ingresado fue correcto o no
      if (nombre == widget.nombrecorrecto){
        confirmacionnombre = 'Nombre Correcto';
        colornombre = Colors.green;
      }
      if (nombre != widget.nombrecorrecto){
        confirmacionnombre = 'Nombre Incorrecto';
        colornombre = Colors.red;
      }

      //Se determina si el apellido ingresado fue correcto o no
      if (apellido == widget.apellidocorrecto){
        confirmacionapellido = 'Apellido Correcto';
        colorapellido = Colors.green;
      }
      if (apellido != widget.apellidocorrecto){
        confirmacionapellido = 'Apellido Incorrecto';
        colorapellido = Colors.red;
      }

      //Se determina si ambos son correctos, para el cambio de pantalla
      if (nombre == widget.nombrecorrecto && apellido == widget.apellidocorrecto)
      {
        context.go //cambio de pantalla
        (
          '/verif',  //hacia donde se envian los datos
          extra: //lista de datos que se envian
            { 
              'nombre': nombre, 
              'apellido': apellido,
              'nombrecorrecto': widget.nombrecorrecto,
              'apellidocorrecto': widget.apellidocorrecto,

            }
          );
      }
    });
  }

  void ocultarapellido(){ //Al ser llamada, invierte el valor de "ocultar", que determina si el apellido es mostrado u ocultado
    setState(() {
      ocultar = !ocultar; //Se invierte el estado de "ocultar"
    });
  }

  //SE TERMINAN LAS VARIABLES Y FUNCIONES
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, 
            children: [  

          Text( //MUESTRA SI EL NOMRE INGRESADO ES CORRECTO O INCORRECTO
            confirmacionnombre, //Puede ser 'Nombre Correcto' o 'Nombre Incorrecto'
            style: TextStyle(
                fontSize: 20,
                color: colornombre,
              )
           ),

           Text( //MUESTRA SI EL APELLIDO INGRESADO ES CORRECTO O INCORRECTO
            confirmacionapellido, //Puede ser 'Apellido Correcto' o 'Apellido Incorrecto'
            style: TextStyle(
                fontSize: 20,
                color: colorapellido,
              )
           ),

           SizedBox(
              height: 10
            ),

            Text(
              nombre, //MUESTRA EL NOMBRE QUE FUE INGRESADO
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            Text(
              apellidomostrar, //MUESTRA EL APELLIDO QUE FUE INGRESADO
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            SizedBox(
              height: 30
            ),

            Padding( //CAJA DE INGRESO DE NOMBRE
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5), //Establece una distancia entre su elemento y los otros elementos

              child: TextField( //CAJA DE INGRESO
                controller: nombreingresado, //Conecta lo que se escribio en la caja con "nombreingresado"
                
                decoration: const InputDecoration( //Estilo de la caja
                labelText: 'Ingrese Nombre',  //Texto que se va a ver en una esquina de la caja
                border: OutlineInputBorder(), //Establece un borde para la caja

                ),
              ),
            ),

            Padding( //CAJA DE INGRESO DE APELLIDO
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5), //Establece una distancia entre su elemento y los otros elementos

              child: TextField( //CAJA DE INGRESO
                controller: apellidoingresado, //Conecta lo que se escribio en la caja con "apellidoingresado"
                obscureText: ocultar, //Si "ocultar" == true, el texto escrito en el apellido se oculta, si "ocultar" == false, el texto escrito en el apellido se muestra

                decoration: const InputDecoration( //Estilo de la caja
                labelText: 'Ingrese Apellido',   //Texto que se va a ver en una esquina de la caja
                border: OutlineInputBorder(),    //Establece un borde para la caja

                ),
              ),
            ),

            ElevatedButton( //BOTON PARA OCULTAR O MOSTRAR EL APELLIDO
              onPressed: ocultarapellido, 
              child: Text('Ocultar', 
              style: TextStyle(
                fontSize: 12,
                ),
              )
            ),
        
            SizedBox(
              height: 30
            ),

            ElevatedButton( //BOTON DE CONFIRMACION DE DATOS
                onPressed: ingreso,
                child: Text('Confirmar')
            ),



          ]
        ) 
      )
    );
  }
}