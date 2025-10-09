import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_provider_agregar_eliminar_lista/entities/loginstate.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/userdata.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/listofgames.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/selecteduser.dart';

final variablesProvider = StateProvider<List<LoginState>>((ref) => listaVariables);
final selecteduserProvider = StateProvider<List<Selected>>((ref) => selectedlist);
final selectedgameProvider = StateProvider<Games?>((ref) => null);

// 🔹 FIREBASE - JUEGOS
final listaJuegosProvider = StateNotifierProvider<juegosNotifier, List<Games>>(
  (ref) => juegosNotifier(FirebaseFirestore.instance),
);

class juegosNotifier extends StateNotifier<List<Games>> {
  final FirebaseFirestore db;
  juegosNotifier(this.db) : super([]);

  Future<void> setgames(Games games) async {
    final doc = db.collection('juegos').doc();
    try {
      await doc.set(games.toFirestore());
      state = [...state, games];
    } catch (e) {
      print(e);
    }
  }

  Future<void> getgames() async {
    final docs = db.collection('juegos').withConverter(
        fromFirestore: Games.fromFirestore,
        toFirestore: (Games games, _) => games.toFirestore());
    final games = await docs.get();
    state = games.docs.map((d) => d.data()).toList();
  }

  Future<void> deletegame(Games game) async {
    if (game.id == null) return;
    try {
      await db.collection('juegos').doc(game.id).delete();
      state = state.where((g) => g.id != game.id).toList();
    } catch (e) {
      print('Error eliminando juego: $e');
    }
  }

  Future<void> updategame(Games game) async {
    if (game.id == null) return;
    try {
      await db.collection('juegos').doc(game.id).update(game.toFirestore());
      state = [
        for (final g in state)
          if (g.id == game.id) game else g
      ];
    } catch (e) {
      print('Error actualizando juego: $e');
    }
  }
}

final listaUsuariosProvider =
    StateNotifierProvider<UsuariosNotifier, List<Users>>(
  (ref) => UsuariosNotifier(FirebaseFirestore.instance),
);

class UsuariosNotifier extends StateNotifier<List<Users>> {
  final FirebaseFirestore db;
  UsuariosNotifier(this.db) : super([]);

  Future<void> getusers() async {
    final docs = db.collection('usuarios').withConverter(
        fromFirestore: Users.fromFirestore,
        toFirestore: (Users user, _) => user.toFirestore());
    final users = await docs.get();
    state = users.docs.map((d) => d.data()).toList();
  }

  Future<void> setuser(Users user) async {
    final doc = db.collection('usuarios').doc();
    try {
      await doc.set(user.toFirestore());
      state = [...state, user];
    } catch (e) {
      print('Error agregando usuario: $e');
    }
  }
}