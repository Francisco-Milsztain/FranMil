import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_usuarios_movies/entities/datosusuarios.dart';
import 'package:flutter_usuarios_movies/entities/juegos.dart';

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
  void regresar() {
    context.go('/confirm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 40),

            Text(
              'Bienvenido ${widget.usuario.nombre} de ${widget.usuario.direccion}',
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: regresar,
              child: Text('Regresar', style: TextStyle(fontSize: 16)),
            ),

            SizedBox(height: 30),

            Expanded(
              child: ListView.builder(
                itemCount: listaJuegos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listaJuegos[index].title),
                    subtitle: Text("By: ${listaJuegos[index].creator}"),
                    leading: Image.network(
                      listaJuegos[index].posterUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
