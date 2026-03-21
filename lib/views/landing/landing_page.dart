import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/views/landing/landing_viewmodel.dart';
import 'package:king_price_pokemon_application/views/login/login_page.dart';
import 'package:king_price_pokemon_application/views/registration/registration_page.dart';
import 'package:king_price_pokemon_application/widgets/app_button.dart';
import 'package:king_price_pokemon_application/widgets/app_coursel.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);
    return ChangeNotifierProvider(
      create: (_) => LandingViewModel(),
      child: Consumer<LandingViewModel>(
        builder: (context, vm, child) => AppTemplate(
          title: 'landing',
          isShowTopBar: true,
          page: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(height: sizes.height * 0.5, child: AppCoursel()),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: sizes.height * 0.2,

                        child: Column(
                          children: [
                            AppButton(
                              text: 'LOG IN',
                              onPressed: () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginPage()),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            AppButton(
                              text: 'REGSITER',

                              isSecondaryButton: true,
                              onPressed: () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const RegistrationPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
