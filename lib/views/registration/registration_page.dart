import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, required this.title});

  final String title;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      title: 'Registtration',
      page: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Registration Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}