import 'package:go_router/go_router.dart';
import 'package:flutter_cambio_de_pantalla/pantallas/confirmacion_pantalla.dart';
import 'package:flutter_cambio_de_pantalla/pantallas/verificado_pantalla.dart';
import 'package:flutter_cambio_de_pantalla/pantallas/inicio.dart';

final appRouter = GoRouter(

	initialLocation: '/inicio',

	routes: 
  [

    GoRoute(
      path:'/inicio',
      builder:(context,state) => 
      Inicial()
    ),

    GoRoute(
      path:'/confirm', 
      builder: (context, state) {
        final datoscorrectos = state.extra as Map<String, String>? ?? {};
        return Confirmacion
        ( //Variables que se reciben
          nombrecorrecto: datoscorrectos['nombrecorrecto'] ?? '',
          apellidocorrecto: datoscorrectos['apellidocorrecto'] ?? '',

        );
      }
    ), 
    
    GoRoute(
      path: '/verif',
      builder: (context, state) {
        final datos = state.extra as Map<String, String>? ?? {};
        return Verificacion
        ( //Variables que se reciben
          nombre: datos['nombre'] ?? '',
          apellido: datos['apellido'] ?? '',
          nombrecorrecto: datos['nombrecorrecto'] ?? '',
          apellidocorrecto: datos['apellidocorrecto'] ?? '',


        );
      },
    ),

	],
);