import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_provider_agregar_eliminar_lista/providers.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/listofgames.dart';

class addgames extends ConsumerWidget {
  TextEditingController ingresotitle = TextEditingController(); 
  TextEditingController ingresocategory = TextEditingController(); 
  TextEditingController ingresocreator = TextEditingController(); 
  TextEditingController ingresoyear = TextEditingController(); 
  TextEditingController ingresoposter = TextEditingController(); 

  addgames({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () { context.go('/gameslist'); },
              child: Text('Regresar', style: TextStyle(fontSize: 16)),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: ingresotitle,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: ingresocategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: ingresocreator,
                decoration: const InputDecoration(
                  labelText: 'Creator',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: ingresoyear,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: ingresoposter,
                decoration: const InputDecoration(
                  labelText: 'Poster',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                final nuevoJuego = Games(
                  title: ingresotitle.text.trim(),
                  category: ingresocategory.text.trim(),
                  creator: ingresocreator.text.trim(),
                  year: ingresoyear.text.trim(),
                  posterUrl: ingresoposter.text.trim(),
                );

                await ref.read(listaJuegosProvider.notifier).setgames(nuevoJuego);

                context.go('/gameslist');
              },
              child: Text('Agregar', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
