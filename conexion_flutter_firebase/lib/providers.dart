//LINK A LA DB
// https://console.firebase.google.com/u/2/project/mi-proyecto1-52250/firestore/data?hl=es-419
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_provider_agregar_eliminar_lista/entities/loginstate.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/userdata.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/listofgames.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/selecteduser.dart';

final variablesProvider = StateProvider<List<LoginState>>((ref) => listaVariables);
final userdataProvider = StateProvider<List<Users>>((ref) => listaUsuarios);
final selecteduserProvider = StateProvider<List<Selected>>((ref) => selectedlist);
final selectedgameProvider = StateProvider<Games?>((ref) => null); //VOY A TENER QUE ARREGLAR ESTO DESPUES CREO??

//PARTE DE FIREBASE (NO TENGO IDEA QUE ESTOY HACIENDO lpm)
// final listaJuegosProvider = StateProvider<List<Games>>((ref) => listaJuegos);

final listaJuegosProvider = StateNotifierProvider<juegosNotifier, List<Games>>(
  (ref) => juegosNotifier(FirebaseFirestore.instance),
);

class juegosNotifier extends StateNotifier<List<Games>> {
  final FirebaseFirestore db;

  juegosNotifier(this.db) : super([]);


  //FUNCION PARA ENVIAR A FIREBASE
  Future<void> setgames(Games games) async {
    final doc = db.collection('juegos').doc();
    try {
      await doc.set(games.toFirestore());
      state = [...state, games];
    } catch (e) {
      print(e);
    }
  }

  //FUNCION PARA LEER DESDE FIREBASE
  Future<void> getgames() async {
    final docs = db.collection('juegos').withConverter(
        fromFirestore: Games.fromFirestore,
        toFirestore: (Games games, _) => games.toFirestore());
    final games = await docs.get();
    state = games.docs.map((d) => d.data()).toList();
  }
}