import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String email;
  String password;
  String nombre;
  String direccion;

  Users({
    this.id,
    required this.email,
    required this.password,
    required this.nombre,
    required this.direccion,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'password': password,
      'nombre': nombre,
      'direccion': direccion,
    };
  }

  static Users fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data()!;
    return Users(
      id: doc.id,
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      nombre: data['nombre'] ?? '',
      direccion: data['direccion'] ?? '',
    );
  }
}
