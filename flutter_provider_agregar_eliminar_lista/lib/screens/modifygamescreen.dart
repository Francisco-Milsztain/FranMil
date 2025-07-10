import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_provider_agregar_eliminar_lista/providers.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/listofgames.dart';

class Modifygame extends ConsumerWidget {
  const Modifygame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final juego = ref.watch(selectedgameProvider);

    if (juego == null) 
    {
     return Scaffold
      (
        body: Center
        (
          child: Text('Ningún juego seleccionado')
        ),
      ); 
    }

    final titleController = TextEditingController(text: juego.title);
    final categoryController = TextEditingController(text: juego.category);
    final posterController = TextEditingController(text: juego.posterUrl);
    final creatorController = TextEditingController(text: juego.creator);
    final yearController = TextEditingController(text: juego.year);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox
            (
              height: 30
            ),

            ElevatedButton
            (
              onPressed: () 
              {
                context.go('/deletegame');
              },
              child: Text
              (
                'Regresar', style: TextStyle(fontSize: 16)
              ),
            ),

            SizedBox
            (
              height: 20
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            ),

            SizedBox
            (
              height: 15
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
            ),

            SizedBox
            (
              height: 15
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: creatorController,
                decoration: InputDecoration(labelText: 'Creator'),
              ),
            ),

            SizedBox
            (
              height: 15
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: yearController,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.text,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: posterController,
                decoration: InputDecoration(labelText: 'Poster'),
              ),
            ),

            SizedBox
            (
              height: 20
            ),

            ElevatedButton(
              onPressed: () {
                final juegoModificado = Games(
                  title: titleController.text,
                  category: categoryController.text,
                  posterUrl: posterController.text,
                  creator: creatorController.text,
                  year: yearController.text,
                );

                final juegosActuales = ref.read(listaJuegosProvider.notifier).state;

                final nuevaLista = [
                  for (final g in juegosActuales)
                    if (g != juego) g,
                  juegoModificado
                ];

                ref.read(listaJuegosProvider.notifier).state = nuevaLista;
                ref.read(selectedgameProvider.notifier).state = juegoModificado;

                context.go('/deletegame');
              },
              child: Text('Guardar cambios', style: TextStyle(fontSize: 16)),
            ),

          ],
        ),
      ),
    );
  }
}
