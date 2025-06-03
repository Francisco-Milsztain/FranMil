import 'package:go_router/go_router.dart';
import 'package:flutter_usuarios_movies/entities/datosusuarios.dart';
import 'package:flutter_usuarios_movies/screens/confirmacion_pantalla.dart';
import 'package:flutter_usuarios_movies/screens/verificado_pantalla.dart';

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
