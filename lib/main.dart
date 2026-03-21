import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/views/registration/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const RegistrationPage(title: 'Flutter Demo Home Page'),
    );
  }
}

