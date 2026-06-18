import 'package:go_router/go_router.dart';
import 'package:zfinal/presentations/screens/agregar.dart';
import 'package:zfinal/presentations/screens/ingreso.dart';
import 'package:zfinal/presentations/screens/miapp.dart';
import 'package:zfinal/presentations/screens/modificar.dart';
import 'package:zfinal/presentations/screens/perfil.dart';
import 'package:zfinal/presentations/screens/registro.dart';
import 'package:zfinal/presentations/screens/ver.dart';
import 'package:zfinal/presentations/screens/favoritos.dart';

final appRouter = GoRouter(
  initialLocation: '/ingreso',
  routes: [
    GoRoute(
      path: '/ingreso',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/miapp',
      builder: (context, state) => ColeccionJuegos(),
    ),
    GoRoute(
      path: '/agregar',
      builder: (context, state) => Agregar(),
    ),
    GoRoute(
      path: '/registro',
      builder: (context, state) => Signup(),
    ),
    GoRoute(
      path: '/ver',
      builder: (context, state) => VerRemera(),
    ),
    GoRoute(
      path: '/modificar',
      builder: (context, state) => Modificar(),
    ),
    GoRoute(
      path: '/perfil',
      builder: (context, state) => Verperfil(),
    ),
    GoRoute(
      path: '/favoritos',      
      builder: (context, state) => const Favoritos(),
    ),
  ],
);
