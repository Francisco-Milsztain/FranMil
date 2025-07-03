import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_provider_agregar_a_lista/providers.dart';
import 'package:flutter_provider_agregar_a_lista/entities/loginstate.dart';


class gameslist extends ConsumerWidget {
  const gameslist({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
  final welcomed_user = ref.watch(selecteduserProvider);
  final juegos = ref.watch(listaJuegosProvider);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 20),

            Text(
              'Bienvenido ${welcomed_user[0].nombre} de ${welcomed_user[0].direccion}',
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () 
              {
                context.go('/start');
                ref.read(variablesProvider.notifier).state = 
                [
                  LoginState
                  (
                    estado_login: 'Ingresar Datos',
                  )
                ];
              },
              child: Text('Regresar', style: TextStyle(fontSize: 16)),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {context.go('/addgames');},
              child: Text('Agregar Juegos', style: TextStyle(fontSize: 16)),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: juegos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(juegos[index].title),
                    subtitle: Text("By: ${juegos[index].creator}"),
                    leading: Image.network(
                      juegos[index].posterUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_not_supported, size: 70);
                      },
                    ),
                    onTap: () 
                    {
                      context.go('/deletegame');
                      ref.read(selectedgameProvider.notifier).state = juegos[index];
                    },
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}