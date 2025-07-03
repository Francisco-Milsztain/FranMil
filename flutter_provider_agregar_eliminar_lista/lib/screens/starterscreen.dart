import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_provider_agregar_a_lista/entities/selecteduser.dart';
import 'package:flutter_provider_agregar_a_lista/entities/loginstate.dart';
import 'package:flutter_provider_agregar_a_lista/providers.dart';


class start extends ConsumerWidget {

  TextEditingController ingresomail = TextEditingController(); 
  TextEditingController ingresopass = TextEditingController(); 

  String aviso = "Ingrese sus datos";

  start({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final basededatos = ref.watch(userdataProvider);
    final estado_variables = ref.watch(variablesProvider);

    return Scaffold(
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: 
          [

            SizedBox(
                height: 50,
              ),

               Text(
              '${estado_variables[0].estado_login}',
              style: TextStyle(fontSize: 20),
              ),

              SizedBox(
                height: 50,
              ),

              Padding( //CAJA DE INGRESO DE EMAIL
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),

                child: TextField( //CAJA DE INGRESO
                  controller: ingresomail, //Conecta lo que se escribio en la caja con "nombreingresado"
                  
                  decoration: const InputDecoration( //Estilo de la caja
                  labelText: 'Email',  //Texto que se va a ver en una esquina de la caja
                  border: OutlineInputBorder(), //Establece un borde para la caja

                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Padding( //CAJA DE INGRESO DE CONTRASEÑA
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5), //Establece una distancia entre su elemento y los otros elementos

                child: TextField( //CAJA DE INGRESO
                  controller: ingresopass, //Conecta lo que se escribio en la caja con "nombreingresado"
                  
                  decoration: const InputDecoration( //Estilo de la caja
                  labelText: 'Contraseña',  //Texto que se va a ver en una esquina de la caja
                  border: OutlineInputBorder(), //Establece un borde para la caja

                  ),
                ),
              ),

              SizedBox(
                height: 50,
              ),

              ElevatedButton(
                onPressed: () 
                {
                  for (var usuario in basededatos) 
                  {
                    if (ingresomail.text == usuario.email && ingresopass.text == usuario.password) 
                    {
                      context.go('/gameslist');
                      ref.read(selecteduserProvider.notifier).state = [
                        Selected(
                          email: ingresomail.text,
                          password: ingresopass.text,
                          nombre: usuario.nombre,
                          direccion: usuario.direccion,
                        )
                      ];
                    }

                    if (ingresomail.text != usuario.email || ingresopass.text != usuario.password)
                    {
                      ref.read(variablesProvider.notifier).state = 
                      [
                        LoginState
                        (
                          estado_login: 'Datos incorrectos',
                        )
                      ];
                    }
                  }
                },

                child: Text('Confirmar'),
              ),

          ]
        )
      ),
    );
  }
}