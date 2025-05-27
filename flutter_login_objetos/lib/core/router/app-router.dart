import 'package:go_router/go_router.dart';
import 'package:flutter_login_objetos/entities/datos.dart';
import 'package:flutter_login_objetos/pantallas/confirmacion_pantalla.dart';
import 'package:flutter_login_objetos/pantallas/verificado_pantalla.dart';

final appRouter = GoRouter(

	initialLocation: '/confirm',

	routes: 
  [

    GoRoute(
      path:'/confirm',
      builder:(context, state) => 
      Confirmacion()
    ),

    
    GoRoute(
      path:'/verif',
      builder:(context, state) 
      {
        final usuario = state.extra as DatosUsuario;
        return Verificacion(usuario: usuario);
      }
    ),

	],
);