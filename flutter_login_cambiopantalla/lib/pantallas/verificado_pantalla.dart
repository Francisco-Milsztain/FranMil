import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Verificacion extends StatefulWidget {

  //Variables que se van a usar en esta pantalla (van a ser recibidas)
  final String nombre;
  final String apellido;
  final String nombrecorrecto;
  final String apellidocorrecto;


  Verificacion({ super.key, //Datos que se espera recibir en esta pantalla
    required this.nombre, 
    required this.apellido,
    required this.nombrecorrecto,
    required this.apellidocorrecto,

  }); 

  @override
  State<Verificacion> createState() => _VerificacionState();
}

class _VerificacionState extends State<Verificacion> {

  void regreso() //Funcion de regreso a la pantalla anterior
  {
    context.go('/confirm',
    extra: //lista de datos que se envian
      { 
        'nombrecorrecto': widget.nombrecorrecto, 
        'apellidocorrecto': widget.apellidocorrecto,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center( 
          child: Column( crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [

              SizedBox(
                height: 100,
              ),
              
              Text(
                'Bienvenido ${widget.nombre} ${widget.apellido}',
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(
                height: 10,
              ),

              ElevatedButton( //BOTON DE REGRESO
                onPressed: regreso,
                child: Text('Volver', 
                style: TextStyle(
                  fontSize: 12,
                  ),
                )
              ),





            ]
          ) 
        )
      )
    );
  }
}