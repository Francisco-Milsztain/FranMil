import 'package:flutter_provider_agregar_eliminar_lista/screens/modifygamescreen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_provider_agregar_eliminar_lista/screens/starterscreen.dart';
import 'package:flutter_provider_agregar_eliminar_lista/screens/gameslistscreen.dart';
import 'package:flutter_provider_agregar_eliminar_lista/screens/addgamesscreen.dart';
import 'package:flutter_provider_agregar_eliminar_lista/screens/deletegamescreen.dart';
import 'package:flutter_provider_agregar_eliminar_lista/screens/modifygamescreen.dart';



final appRouter = GoRouter(

	initialLocation: '/start',

	routes: 
  [

    GoRoute(
      path:'/start',
      builder:(context, state) => 
      start()
    ),

    GoRoute(
      path:'/gameslist',
      builder:(context, state) => 
      GamesListScreen()
    ),

    GoRoute(
      path:'/addgames',
      builder:(context, state) => 
      addgames()
    ),

    GoRoute(
      path:'/deletegame',
      builder:(context, state) => 
      Deletegame()
    ),

    GoRoute(
      path:'/modifygame',
      builder:(context, state) => 
      Modifygame()
    ),

	],
);