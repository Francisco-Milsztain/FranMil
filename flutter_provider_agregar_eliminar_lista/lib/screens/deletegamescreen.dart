import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_provider_agregar_eliminar_lista/providers.dart';
class Deletegame extends ConsumerWidget {
  const Deletegame({super.key});

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

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30
            ),

           ElevatedButton(
              onPressed: () {context.go('/gameslist');},
              child: Text('Regresar', style: TextStyle(fontSize: 16)),
            ),

            SizedBox(
              height: 30
            ),

            Image.network
            (
              juego!.posterUrl,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 100);
              },
            ),

            SizedBox(
              height: 20
            ),

            Text(
              "Title: ${juego.title}", 
              style: TextStyle(fontSize: 20)
            ),

            SizedBox(
              height: 10
            ),
            
            Text(
              "Category: ${juego.category}", 
              style: TextStyle(fontSize: 20)
            ),

            SizedBox(
              height: 10
            ),
            
            Text(
              "Category: ${juego.creator}", 
              style: TextStyle(fontSize: 20)
            ),

            SizedBox(
              height: 10
            ),
            
            Text(
              "Category: ${juego.year}", 
              style: TextStyle(fontSize: 20)
            ),

            SizedBox(
              height: 20
            ),

           ElevatedButton(
              onPressed: () 
              {
                context.go('/gameslist');

                final listaModificable = [...ref.read(listaJuegosProvider.notifier).state];
                listaModificable.remove(juego);

                ref.read(listaJuegosProvider.notifier).state = listaModificable;
                ref.read(selectedgameProvider.notifier).state = null;
              },

              child: Text('ELIMINAR', style: TextStyle(fontSize: 16)),
            ),

            SizedBox(
              height: 20
            ),
            
            ElevatedButton(
              onPressed: () 
              {
                context.go('/modifygame');
              },

              child: Text('MODIFICAR', style: TextStyle(fontSize: 16)),
            ),

            
          ]
        )  
      ),
    );
  }
}