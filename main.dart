// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

void main() { //Se inicia la aplicación, con MainApp siendo el widget principal
  runApp(const MainApp());
}

class MainApp extends StatelessWidget { //MainApp, al ser el widget principal, no va a cambiar, por lo que es un StatelessWidget (énfasis en less)
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: pagina(), //Se establece a "pagina" como la pantalla principal
    );
  }
}

class pagina extends StatefulWidget { //"pagina" va a cambiar, por lo que es un StatefulWidget (énfasis en ful)
  const pagina({super.key});

  @override
  State<pagina> createState() => estadopagina(); //Se crea un estado para "pagina", y los cambios de este estado van a ser manejados por "estadopagina" 
}

class estadopagina extends State<pagina> { //"estadopagina" controla el estado de "pagina", por medio de los setState()

//SE PROGRAMA DE ACA PARA ABAJO

  //Variables
  String data = 'No presionado';

  //Funciones
  void presionado() {
    setState(() {
      data = 'Presionado';
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center( //Todo lo que venga abajo va a estar en el centro
        child: Column( //Los elementos se van a posicionar uno arriba del otro, en el orden en el que están escritos  
          mainAxisAlignment: MainAxisAlignment.center,

          //Elementos
          children: [
            const Text(
              'Holis',
              style: TextStyle(fontSize: 40),
            ),

            SizedBox(
              height: 20
            ), 

            Text(
              data,
              style: const TextStyle(fontSize: 20),
            ),

            ElevatedButton(
              onPressed: presionado,
              child: const Text('Presionar'),
            ),

          ],
        ),
      ),
    );
  }
}