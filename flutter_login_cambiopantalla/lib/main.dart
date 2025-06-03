import 'package:flutter/material.dart';
import 'package:flutter_cambio_de_pantalla/core/router/app-router.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,

    );
  }
}