import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:zfinal/entities/juego.dart';
import 'package:zfinal/presentations/providers.dart';

class Favoritos extends ConsumerStatefulWidget {
  const Favoritos({super.key});

  @override
  ConsumerState<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends ConsumerState<Favoritos> {
  List<DocumentSnapshot> favoritas = [];

  Future<void> _cargarFavoritos() async {
    final usuario = ref.read(usuarioLogueadoProvider);
    if (usuario == null) return;

    final userDoc = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(usuario.usuario)
        .get();

    final data = userDoc.data();
    final favoritosStr = data?['favoritos'] ?? '';
    final favoritosList =
        favoritosStr.isEmpty ? <String>[] : favoritosStr.split(',');

    if (favoritosList.isEmpty) {
      setState(() => favoritas = []);
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('juegos')
        .where('title', whereIn: favoritosList)
        .get();

    setState(() {
      favoritas = snapshot.docs;
    });
  }

  @override
  void initState() {
    super.initState();
    _cargarFavoritos();
  }
@override
Widget build(BuildContext context) {
  final usuario = ref.watch(usuarioLogueadoProvider);

  return Scaffold(
    appBar: AppBar(
      title: const Text("Mis Favoritos"),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.go('/miapp'),
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: favoritas.length,
      itemBuilder: (context, index) {
        final juegoData = favoritas[index].data() as Map<String, dynamic>;

        final juego = Juego(
          id: juegoData['id'] ?? '',
          title: juegoData['title'] ?? '',
          category: juegoData['category'] ?? '',
          creator: juegoData['creator'] ?? '',
          posterUrl: juegoData['posterUrl'] ?? '',
          year: juegoData['year'] ?? '',
        );

        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: Image.network(
              juego.posterUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(juego.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Category: ${juego.category}"),
                Text("Creator: ${juego.creator}"),
                Text("Año: ${juego.year}"),
              ],
            ),
            onTap: () {
              ref.read(juegoSeleccionadoProvider.notifier).state = juego;
              context.go('/ver');
            },
          ),
        );
      },
    ),
  );
}
}