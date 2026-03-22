import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:king_price_pokemon_application/views/login/login_page.dart'; // <-- import your login page

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.primary),
          child: Center(
            child: Image(
              height: AppSizes(context).height * 0.1,
              image: AssetImage('assets/branding/applogo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
