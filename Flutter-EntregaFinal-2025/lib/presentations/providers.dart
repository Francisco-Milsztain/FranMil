import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/usuarios.dart';
import '../entities/juego.dart';

/// ---------------- Providers globales ----------------

final juegoSeleccionadoProvider = StateProvider<Juego?>((ref) => null);

final listajuegosprovider =
    StateNotifierProvider<JuegosNotifier, List<Juego>>(
  (ref) => JuegosNotifier(FirebaseFirestore.instance),
);

final listausuariosprovider =
    StateNotifierProvider<UsuariosNotifier, List<Logueo>>(
  (ref) => UsuariosNotifier(FirebaseFirestore.instance),
);

final usuarioLogueadoProvider = StateProvider<Logueo?>((ref) => null);

final favoritosProvider =
    StateNotifierProvider<FavoritosNotifier, List<Juego>>(
  (ref) => FavoritosNotifier(FirebaseFirestore.instance),
);

/// ---------------- JuegosNotifier ----------------
class JuegosNotifier extends StateNotifier<List<Juego>> {
  final FirebaseFirestore db;
  JuegosNotifier(this.db) : super([]);

Future<void> addJuego(Juego juego) async {
    try {
      final doc = db.collection('juegos').doc(); 
      final juegoConId = Juego(
        id: doc.id,
        title: juego.title,
        category: juego.category,
        creator: juego.creator,
        posterUrl: juego.posterUrl,
        year: juego.year,
      );
      await doc.set(juegoConId.toFirestore());
      state = [...state, juegoConId];
    } catch (e) {
      print("Error al agregar juego: $e");
    }
  }

  Future<void> getJuegos() async {
    try {
      final snapshot = await db
          .collection('juegos')
          .withConverter<Juego>(
            fromFirestore: (doc, options) => Juego.fromFirestore(doc, options),
            toFirestore: (j, options) => j.toFirestore(),
          )
          .get();
      state = snapshot.docs.map((d) => d.data()).toList();
    } catch (e) {
      print("Error al obtener juegos: $e");
    }
  }

  Future<void> removeJuego(Juego juego) async {
    try {
      final docs =
          await db.collection('juegos').where('id', isEqualTo: juego.id).get();
      for (var doc in docs.docs) {
        await doc.reference.delete();
      }
      state = state.where((r) => r.id != juego.id).toList();
    } catch (e) {
      print("Error al eliminar juego: $e");
    }
  }
}

/// ---------------- UsuariosNotifier ----------------
class UsuariosNotifier extends StateNotifier<List<Logueo>> {
  final FirebaseFirestore db;
  UsuariosNotifier(this.db) : super([]);

  Future<void> addUsuario(Logueo usuario) async {
    try {
      final docRef = db.collection('Usuarios').doc();
      await docRef.set(usuario.toFirestore());
      state = [...state, usuario];
    } catch (e) {
      print("Error al agregar usuario: $e");
    }
  }

  Future<void> getUsuarios() async {
    try {
      final snapshot = await db
          .collection('Usuarios')
          .withConverter<Logueo>(
            fromFirestore: (doc, options) => Logueo.fromFirestore(doc, options),
            toFirestore: (u, options) => u.toFirestore(),
          )
          .get();
      state = snapshot.docs.map((d) => d.data()).toList();
    } catch (e) {
      print("Error al obtener usuarios: $e");
    }
  }

  Future<Logueo?> login(String email, String contrasena, WidgetRef ref) async {
    try {
      final snapshot = await db
          .collection('Usuarios')
          .withConverter<Logueo>(
            fromFirestore: (doc, options) => Logueo.fromFirestore(doc, options),
            toFirestore: (u, options) => u.toFirestore(),
          )
          .where('email', isEqualTo: email.trim().toLowerCase())
          .get();

      if (snapshot.docs.isNotEmpty) {
        final logueado = snapshot.docs.first.data();
        if (logueado.contrasena.trim() == contrasena) {
          ref.read(usuarioLogueadoProvider.notifier).state = logueado;
          return logueado;
        } else {
          print("Contraseña incorrecta para $email");
          return null;
        }
      }
      print("No se encontró usuario con email $email");
      return null;
    } catch (e) {
      print("Error login: $e");
      return null;
    }
  }
}

/// ---------------- FavoritosNotifier ----------------
class FavoritosNotifier extends StateNotifier<List<Juego>> {
  final FirebaseFirestore db;
  FavoritosNotifier(this.db) : super([]);

  Future<void> addFavorito(Juego juego, String uid) async {
    try {
      final docRef = db
          .collection('Usuarios')
          .doc(uid)
          .collection('favoritos')
          .doc(juego.id)
          .withConverter<Juego>(
            fromFirestore: (doc, options) => Juego.fromFirestore(doc, options),
            toFirestore: (r, options) => r.toFirestore(),
          );
      await docRef.set(juego);
      state = [...state, juego];
    } catch (e) {
      print("Error al agregar favorito: $e");
    }
  }

  Future<void> removeFavorito(Juego juego, String uid) async {
    try {
      final docRef = db
          .collection('Usuarios')
          .doc(uid)
          .collection('favoritos')
          .doc(juego.id)
          .withConverter<Juego>(
            fromFirestore: (doc, options) => Juego.fromFirestore(doc, options),
            toFirestore: (r, options) => r.toFirestore(),
          );
      await docRef.delete();
      state = state.where((r) => r.id != juego.id).toList();
    } catch (e) {
      print("Error al eliminar favorito: $e");
    }
  }

  Future<void> loadFavoritos(String uid) async {
    try {
      final snapshot = await db
          .collection('Usuarios')
          .doc(uid)
          .collection('favoritos')
          .withConverter<Juego>(
            fromFirestore: (doc, options) => Juego.fromFirestore(doc, options),
            toFirestore: (r, options) => r.toFirestore(),
          )
          .get();
      state = snapshot.docs.map((d) => d.data()).toList();
    } catch (e) {
      print("Error al cargar favoritos: $e");
    }
  }
}
