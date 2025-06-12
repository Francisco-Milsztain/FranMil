import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_provider_agregar_a_lista/providers.dart';
import 'package:flutter_provider_agregar_a_lista/entities/listofgames.dart';


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
        child:  Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: 
          [
            SizedBox(
                height: 10,
              ),

            ElevatedButton(
              onPressed: () {context.go('/gameslist');},
              child: Text('Regresar', style: TextStyle(fontSize: 16)),
            ),

            SizedBox(
                height: 20,
            ),

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

              SizedBox(
                height: 30,
              ),

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

              SizedBox(
                height: 30,
              ),

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

              SizedBox(
                height: 30,
              ),

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

              SizedBox(
                height: 30,
              ),

              ElevatedButton(
              onPressed: () 
              {
                

                final nuevoJuego = Games(
                  title: ingresotitle.text,
                  category: ingresocategory.text,
                  creator: ingresocreator.text,
                  year: int.parse(ingresoyear.text),
                  posterUrl: ingresoposter.text,
                );

                final juegos_actuales = ref.read(listaJuegosProvider.notifier);
                juegos_actuales.state = [...juegos_actuales.state, nuevoJuego];
                
                context.go('/gameslist');
              },
              child: Text('Agregar', style: TextStyle(fontSize: 16)),
            ),

          ]
        )
      ),
    );
  }
}
