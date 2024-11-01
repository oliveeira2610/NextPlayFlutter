import 'package:flutter/material.dart';
import 'package:projeto_nextplay/pages/loadingpage.dart';
import 'package:projeto_nextplay/pages/login.dart';
import 'package:projeto_nextplay/pages/Cadastro.dart';
import 'package:projeto_nextplay/pages/home.dart';
import 'package:projeto_nextplay/pages/loadingpage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      routes: {
        '/loading' : (context) => Loadingpage(),
        '/login' : (context) => Login(),
        '/cadastro' : (context) =>  const Cadastro(),
        '/home' : (context) =>  Home(),
      },
      
    );
  }
}
