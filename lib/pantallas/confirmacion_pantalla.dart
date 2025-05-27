import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_login_objetos/entities/datos.dart';

class Confirmacion extends StatefulWidget {
  Confirmacion({super.key});

  @override
  State<Confirmacion> createState() => _MyWidgetState();
}

DatosUsuario Usuario1 = DatosUsuario(email: 'francisco@gmail.com', password: '12345',  nombre: 'Francisco', direccion: 'ORT Yatay');
DatosUsuario Usuario2 = DatosUsuario(email: 'javier@gmail.com',    password: '54321',  nombre: 'Javier',    direccion: 'ORT Belgrano');
DatosUsuario Usuario3 = DatosUsuario(email: 'pedro@gmail.com',     password: 'abcde',  nombre: 'Pedro',     direccion: 'ORT Tigre');
DatosUsuario Usuario4 = DatosUsuario(email: 'fabian@gmail.com',    password: 'edcba',  nombre: 'Fabian',    direccion: 'ORT Uruguay');
DatosUsuario Usuario5 = DatosUsuario(email: 'tomas@gmail.com',     password: 'javier', nombre: 'Tomas',     direccion: 'ORT Polonia');


class _MyWidgetState extends State<Confirmacion> {

  TextEditingController ingresomail = TextEditingController(); 
  TextEditingController ingresopass = TextEditingController(); 

  void confirmar()
  {
    //USUARIO1
    if (ingresomail.text == Usuario1.email && ingresopass.text == Usuario1.password)
    {
      context.go(
        '/verif',
        extra: Usuario1,
      );
    }

    //USUARIO2
    if (ingresomail.text == Usuario2.email && ingresopass.text == Usuario2.password)
    {
      context.go(
        '/verif',
        extra: Usuario2,
      );
    }

    //USUARIO3
    if (ingresomail.text == Usuario3.email && ingresopass.text == Usuario3.password)
    {
      context.go(
        '/verif',
        extra: Usuario3,
      );
    }

    //USUARIO4
    if (ingresomail.text == Usuario4.email && ingresopass.text == Usuario4.password)
    {
      context.go(
        '/verif',
        extra: Usuario4,
      );
    }

    //USUARIO5
    if (ingresomail.text == Usuario5.email && ingresopass.text == Usuario5.password)
    {
      context.go(
        '/verif',
        extra: Usuario5,
      );
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
                "Ingrese sus datos",
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