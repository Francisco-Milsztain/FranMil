import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zfinal/entities/juego.dart';
import 'package:zfinal/presentations/providers.dart';

class Modificar extends ConsumerWidget {
  Modificar({super.key});

  final TextEditingController modificarId = TextEditingController();
  final TextEditingController modificartitulo = TextEditingController();
  final TextEditingController modificarcategoria = TextEditingController();
  final TextEditingController modificarcreador = TextEditingController();
  final TextEditingController modificarPosterUrl = TextEditingController();
  final TextEditingController modificaryear = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quitar = ref.watch(juegoSeleccionadoProvider)!;
    final juego = ref.watch(juegoSeleccionadoProvider)!;

    modificarId.text = juego.id;
    modificartitulo.text = juego.title;
    modificarcategoria.text = juego.category;
    modificarcreador.text = juego.creator;
    modificarPosterUrl.text = juego.posterUrl;
    modificaryear.text = juego.year;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Modificar juego"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              // ID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: modificarId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                  ),
                ),
              ),

              // Titulo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: modificartitulo,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Titulo',
                  ),
                ),
              ),

              // Categoria
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: modificarcategoria,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Categoria',
                  ),
                ),
              ),

              // Creador
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: modificarcreador,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Creador',
                  ),
                ),
              ),

              // Poster URL
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: modificarPosterUrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Poster',
                  ),
                ),
              ),

              // Año
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: modificaryear,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Año',
                  ),
                ),
              ),

              // Botón confirmar
              ElevatedButton(
                onPressed: () async {
                  final Mid = modificarId.text;
                  final Mtitle = modificartitulo.text;
                  final Mcategory = modificarcategoria.text;
                  final Mcreator = modificarcreador.text;
                  final MposterUrl = modificarPosterUrl.text;
                  final Myear = modificaryear.text;

                  final nuevoJuego = Juego(
                    id: Mid,
                    title: Mtitle,
                    category: Mcategory,
                    creator: Mcreator,
                    posterUrl: MposterUrl,
                    year: Myear,
                  );

                  await ref.read(listajuegosprovider.notifier).addJuego(nuevoJuego);
                  await ref.read(listajuegosprovider.notifier).removeJuego(quitar);

                  context.go('/miapp');
                },
                child: const Text('Confirmar'),
              ),

              // Botón volver
              ElevatedButton(
                onPressed: () => context.go('/miapp'),
                child: const Text("Volver", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
