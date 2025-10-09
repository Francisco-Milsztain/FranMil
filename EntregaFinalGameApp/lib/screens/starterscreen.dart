import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_provider_agregar_eliminar_lista/entities/selecteduser.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/loginstate.dart';
import 'package:flutter_provider_agregar_eliminar_lista/providers.dart';
import 'package:flutter_provider_agregar_eliminar_lista/entities/userdata.dart';

class start extends ConsumerWidget {
  final TextEditingController ingresomail = TextEditingController();
  final TextEditingController ingresopass = TextEditingController();

  start({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado_variables = ref.watch(variablesProvider);
    final usuarios = ref.watch(listaUsuariosProvider);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            Text(
              estado_variables[0].estado_login,
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 50),

            // EMAIL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: ingresomail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // PASSWORD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                controller: ingresopass,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: () async {
                // 🔹 Si la lista está vacía, cargamos desde Firestore
                if (usuarios.isEmpty) {
                  await ref.read(listaUsuariosProvider.notifier).getusers();
                }

                final usuariosActuales =
                    ref.read(listaUsuariosProvider.notifier).state;

                bool encontrado = false;

                for (var usuario in usuariosActuales) {
                  if (ingresomail.text == usuario.email &&
                      ingresopass.text == usuario.password) {
                    encontrado = true;

                    ref.read(selecteduserProvider.notifier).state = [
                      Selected(
                        email: usuario.email,
                        password: usuario.password,
                        nombre: usuario.nombre,
                        direccion: usuario.direccion,
                      )
                    ];

                    ref.read(variablesProvider.notifier).state = [
                      LoginState(estado_login: 'Ingreso exitoso'),
                    ];

                    context.go('/gameslist');
                    break;
                  }
                }

                if (!encontrado) {
                  ref.read(variablesProvider.notifier).state = [
                    LoginState(estado_login: 'Datos incorrectos'),
                  ];
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
