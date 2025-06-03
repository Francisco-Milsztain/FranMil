import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_usuarios_movies/entities/datosusuarios.dart';

class Confirmacion extends StatefulWidget {
  Confirmacion({super.key});

  @override
  State<Confirmacion> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Confirmacion> {

  TextEditingController ingresomail = TextEditingController(); 
  TextEditingController ingresopass = TextEditingController(); 

  String aviso = "Ingrese sus datos";

  void confirmar()
  {
    for (var usuario in listaUsuarios) {
      if (ingresomail.text == usuario.email && ingresopass.text == usuario.password) 
      {
        context.go(
          '/verif',
          extra: usuario,
        );
        return;
      }
      
      setState(() 
      {
        aviso = "Datos incorrectos";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center( 
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [

              SizedBox(
                height: 50,
              ),

              Text(
                aviso,
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(
                height: 50,
              ),

              Padding( //CAJA DE INGRESO DE EMAIL
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),

                child: TextField( //CAJA DE INGRESO
                  controller: ingresomail, //Conecta lo que se escribio en la caja con "nombreingresado"
                  
                  decoration: const InputDecoration( //Estilo de la caja
                  labelText: 'Email',  //Texto que se va a ver en una esquina de la caja
                  border: OutlineInputBorder(), //Establece un borde para la caja

                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Padding( //CAJA DE INGRESO DE CONTRASEÑA
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5), //Establece una distancia entre su elemento y los otros elementos

                child: TextField( //CAJA DE INGRESO
                  controller: ingresopass, //Conecta lo que se escribio en la caja con "nombreingresado"
                  
                  decoration: const InputDecoration( //Estilo de la caja
                  labelText: 'Contraseña',  //Texto que se va a ver en una esquina de la caja
                  border: OutlineInputBorder(), //Establece un borde para la caja

                  ),
                ),
              ),

              SizedBox(
                height: 50,
              ),

              ElevatedButton( //BOTON DE REGRESO
                onPressed: confirmar,
                child: Text('Confirmar', 
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