import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zfinal/presentations/providers.dart';

class Verperfil extends ConsumerWidget {
  const Verperfil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuarioActual = ref.watch(usuarioLogueadoProvider);


    if (usuarioActual == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Perfil')),
        body: const Center(child: Text('No hay usuario logueado.')),
      );
    }

    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                Text("Nombre: ${usuarioActual.usuario}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 18),
                Text("Email: ${usuarioActual.email}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 18),
                Text("Teléfono: ${usuarioActual.telefono}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 18),
                Text("Dirección: ${usuarioActual.direccion}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 18),
                ElevatedButton(
                onPressed: () => context.go('/miapp'),
                child: const Text("Volver", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
