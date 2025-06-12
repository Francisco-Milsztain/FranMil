import 'package:go_router/go_router.dart';
import 'package:flutter_provider_agregar_a_lista/screens/starterscreen.dart';
import 'package:flutter_provider_agregar_a_lista/screens/gameslistscreen.dart';
import 'package:flutter_provider_agregar_a_lista/screens/addgamesscreen.dart';

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
      gameslist()
    ),

    GoRoute(
      path:'/addgames',
      builder:(context, state) => 
      addgames()
    ),

	],
);