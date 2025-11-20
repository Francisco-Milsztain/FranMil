import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zfinal/presentations/providers.dart';

class ColeccionJuegos extends ConsumerStatefulWidget {
  const ColeccionJuegos({super.key});

  @override
  ConsumerState<ColeccionJuegos> createState() => _ColeccionJuegosState();
}

class _ColeccionJuegosState extends ConsumerState<ColeccionJuegos> {
  @override
  void initState() {
    super.initState();
    ref.read(listajuegosprovider.notifier).getJuegos();
  }

  @override
  Widget build(BuildContext context) {
    final juego = ref.watch(listajuegosprovider);
    final usuarioActual = ref.watch(usuarioLogueadoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Juegos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Ver perfil',
            onPressed: () => context.go('/perfil'),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Ver favoritos',
            onPressed: () => context.go('/favoritos'), 
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: juego.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(juego[index].title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Categoria: ${juego[index].category}"),
                  Text("Creador: ${juego[index].creator}"),
                  Text("Año: ${juego[index].year}"),
                ],
              ),
              leading: Image.network(
                juego[index].posterUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),

              onTap: () {
                ref.read(juegoSeleccionadoProvider.notifier).state =
                    juego[index];
                context.go('/ver');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/agregar'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
