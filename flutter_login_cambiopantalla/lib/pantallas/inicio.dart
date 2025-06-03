import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Inicial extends StatefulWidget {
  const Inicial({super.key});

  @override
  State<Inicial> createState() => _inicialState();
}

class _inicialState extends State<Inicial> {

  TextEditingController ingresonombre = TextEditingController();   //Establece a "nombreingresado" como controlador de texto (lee lo que se escribe en "nombreingresado")
  TextEditingController ingresoapellido = TextEditingController(); //Establece a "apellidoingresado" como controlador de texto (lee lo que se escribe en "apellidoingresado")

  String nombrecorrecto = '';
  String apellidocorrecto = '';


  void envioinicial()
  {

    nombrecorrecto = ingresonombre.text;     //El nombre que fue ingresado es establecido como el correcto
    apellidocorrecto = ingresoapellido.text; //El apellido que fue ingresado es establecido como el correcto

    context.go //cambio de pantalla
        (
          '/confirm',  //hacia donde se envian los datos
          extra: //lista de datos que se envian
            { 
              'nombrecorrecto': nombrecorrecto, 
              'apellidocorrecto': apellidocorrecto,
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
                height: 50,
              ),

              Text(
                'Crear datos',
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(
                height: 50,
              ),

              Padding( //CAJA DE INGRESO DE NOMBRE
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5), //Establece una distancia entre su elemento y los otros elementos

              child: TextField( //CAJA DE INGRESO
                controller: ingresonombre, //Conecta lo que se escribio en la caja con "nombreingresado"
                
                decoration: const InputDecoration( //Estilo de la caja
                labelText: 'Nombre',  //Texto que se va a ver en una esquina de la caja
                border: OutlineInputBorder(), //Establece un borde para la caja

                ),
              ),
            ),

              SizedBox(
                height: 20,
              ),

              Padding( //CAJA DE INGRESO DE NOMBRE
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5), //Establece una distancia entre su elemento y los otros elementos

                child: TextField( //CAJA DE INGRESO
                  controller: ingresoapellido, //Conecta lo que se escribio en la caja con "nombreingresado"
                  
                  decoration: const InputDecoration( //Estilo de la caja
                  labelText: 'Apellido',  //Texto que se va a ver en una esquina de la caja
                  border: OutlineInputBorder(), //Establece un borde para la caja

                  ),
                ),
              ),

              SizedBox(
                height: 50,
              ),

              ElevatedButton( //BOTON DE REGRESO
                onPressed: envioinicial,
                child: Text('Establecer datos', 
                style: TextStyle(
                  fontSize: 16,
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