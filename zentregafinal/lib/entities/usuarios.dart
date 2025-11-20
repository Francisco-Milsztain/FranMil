import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logueo {
  final String usuario;
  final String email;
  final String telefono;
  final String direccion;
  final String contrasena;

  Logueo({
    required this.usuario,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.contrasena,
  });


  Map<String, dynamic> toFirestore() {
    return {
      'usuario': usuario,
      'email': email,
      'telefono': telefono,
      'direccion': direccion,
      'contrasena': contrasena,
    };
  }

  static Logueo fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Logueo(
      usuario: data?['usuario'] ?? '',
      email: data?['email'] ?? '',
      telefono: data?['telefono'] ?? '',
      direccion: data?['direccion'] ?? '',
      contrasena: data?['contrasena'] ?? '',
    );
  }
}
