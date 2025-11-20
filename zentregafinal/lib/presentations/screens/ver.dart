import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:zfinal/presentations/providers.dart';

class VerRemera extends ConsumerWidget {
  const VerRemera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juego = ref.watch(juegoSeleccionadoProvider)!;
    final usuario = ref.watch(usuarioLogueadoProvider);

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Juego")),
        body: const Center(child: Text("No hay usuario logueado.")),
      );
    }

    final userDoc = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(usuario.usuario);

    return Scaffold(
      appBar: AppBar(title: Text(juego.title)),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.network(juego.posterUrl, height: 200, fit: BoxFit.cover),

              const SizedBox(height: 20),

              Text("Titulo: ${juego.title}",
                  style: const TextStyle(fontSize: 18)),
              Text("Categoria: ${juego.category}",
                  style: const TextStyle(fontSize: 16)),
              Text("Creador: ${juego.creator}",
                  style: const TextStyle(fontSize: 16)),
              Text("Año: ${juego.year}",
                  style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 30),

              // ---- AGREGAR FAVORITOS ----
              ElevatedButton(
                onPressed: () async {
                  final snapshot = await userDoc.get();
                  final favoritosStr = snapshot.data()?['favoritos'] ?? "";
                  List<String> favoritos =
                      favoritosStr.isEmpty ? [] : favoritosStr.split(',');

                  if (!favoritos.contains(juego.title)) {
                    favoritos.add(juego.title);
                    await userDoc.set(
                      {'favoritos': favoritos.join(',')},
                      SetOptions(merge: true),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Agregado a favoritos")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ya está en favoritos")),
                    );
                  }

                  context.go('/miapp');
                },
                child: const Text("Agregar a Favoritos"),
              ),

              const SizedBox(height: 15),

              // ---- ELIMINAR FAVORITOS ----
              ElevatedButton(
                onPressed: () async {
                  final snapshot = await userDoc.get();
                  final favoritosStr = snapshot.data()?['favoritos'] ?? "";
                  List<String> favoritos =
                      favoritosStr.isEmpty ? [] : favoritosStr.split(',');

                  if (favoritos.contains(juego.title)) {
                    favoritos.remove(juego.title);
                    await userDoc.set(
                      {'favoritos': favoritos.join(',')},
                      SetOptions(merge: true),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Eliminado de favoritos")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No está en favoritos")),
                    );
                  }

                  context.go('/miapp');
                },
                child: const Text("Eliminar de Favoritos"),
              ),

              const SizedBox(height: 15),

              // ---- ELIMINAR JUEGO ----
              ElevatedButton(
                onPressed: () async {
                  final docs = await FirebaseFirestore.instance
                      .collection('juegos')
                      .where('title', isEqualTo: juego.title)
                      .get();

                  for (var doc in docs.docs) {
                    await doc.reference.delete();
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Juego eliminado")),
                  );

                  context.go('/miapp');
                },
                child: const Text("Eliminar juego"),
              ),

              const SizedBox(height: 15),

              // ---- MODIFICAR JUEGO ----
              ElevatedButton(
                onPressed: () {
                  context.go('/modificar');
                },
                child: const Text("Modificar juego"),
              ),

              const SizedBox(height: 10),

              // ---- VOLVER ----
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
