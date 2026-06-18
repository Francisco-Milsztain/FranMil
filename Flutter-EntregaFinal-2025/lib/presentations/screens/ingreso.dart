import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zfinal/presentations/providers.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  String mensaje = '';
  Color colorMensaje = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),


              if (mensaje.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    mensaje,
                    style: TextStyle(fontSize: 16, color: colorMensaje),
                  ),
                ),

   
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),


              TextField(
                controller: contrasenaController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
              const SizedBox(height: 30),


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () async {
                  String email = emailController.text.trim().toLowerCase();
                  String contrasena = contrasenaController.text.trim();

                  if (email.isEmpty || contrasena.isEmpty) {
                    setState(() {
                      mensaje = 'Por favor, completa todos los campos.';
                      colorMensaje = Colors.red;
                    });
                    return;
                  }

                  try {
  
                    final usuarioValido = await ref
                        .read(listausuariosprovider.notifier)
                        .login(email, contrasena, ref);

                    if (usuarioValido != null) {
                      setState(() {
                        mensaje = '';
                      });

 
                      context.go('/miapp');
                    } else {
                      setState(() {
                        mensaje = 'Email o contraseña incorrectos.';
                        colorMensaje = Colors.red;
                      });
                    }
                  } catch (e) {
                    setState(() {
                      mensaje = 'Error al iniciar sesión: $e';
                      colorMensaje = Colors.red;
                    });
                  }
                },
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  context.go('/registro');
                },
                child: const Text(
                  "Crear nueva cuenta",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
