import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zfinal/entities/juego.dart';
import 'package:zfinal/presentations/providers.dart';

class Agregar extends ConsumerWidget {
  Agregar({super.key});

  final TextEditingController agregarid = TextEditingController();
  final TextEditingController agregartitulo = TextEditingController();
  final TextEditingController agregarcategoria= TextEditingController();
  final TextEditingController agregarcreador = TextEditingController();
  final TextEditingController agregarposterUrl = TextEditingController();
  final TextEditingController agregaryear = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar juego")),
      body: Center(
        child: Center(
          child: Column(
            children: [
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: agregarid,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                  ),
                ),
              ),
           
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: agregartitulo,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Titulo',
                  ),
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: agregarcategoria,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Categoria',
                  ),
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: agregarcreador,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Creador',
                  ),
                ),
              ),
         
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: agregarposterUrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Poster',
                  ),
                ),
              ),
     
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: agregaryear,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Año',
                  ),
                ),
              ),


              ElevatedButton(
                onPressed: () async {
                  final nuevoJuego = Juego(
                    id: agregarid.text,
                    title: agregartitulo.text,
                    creator: agregarcreador.text,
                    category: agregarcategoria.text,
                    year: agregaryear.text,
                    posterUrl: agregarposterUrl.text,
                  );

                  await ref.read(listajuegosprovider.notifier).addJuego(nuevoJuego);
                  
                  agregarid.clear();
                  agregartitulo.clear();
                  agregarcreador.clear();
                  agregarcategoria.clear();
                  agregaryear.clear();
                  agregarposterUrl.clear();
                },
                child: const Text("Agregar"),
              ),

              ElevatedButton(
                onPressed: () => context.go('/miapp'),
                child: const Text("Volver"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
