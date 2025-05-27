import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_login_objetos/entities/datos.dart';

class Verificacion extends StatefulWidget {

  final DatosUsuario usuario;

  const Verificacion({
    super.key,
    required this.usuario,
  });

  @override
  State<Verificacion> createState() => _VerificacionState();
}

class _VerificacionState extends State<Verificacion> {

  void regresar()
  {
    context.go('/confirm');
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
                height: 100,
              ),

              Text(
                'Bienvenido ${widget.usuario.nombre} de ${widget.usuario.direccion}',
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(
                height: 50,
              ),

              ElevatedButton( //BOTON DE REGRESO
                onPressed: regresar,
                child: Text('Regresar', 
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