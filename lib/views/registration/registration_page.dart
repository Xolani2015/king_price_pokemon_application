// pages/registration_page.dart
import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/models/user_model.dart';
import 'package:king_price_pokemon_application/views/login/login_page.dart';
import 'package:king_price_pokemon_application/views/registration/registration_viewmodel.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:king_price_pokemon_application/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, required this.title});
  final String title;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrationViewModel(),
      child: Consumer<RegistrationViewModel>(
        builder: (context, vm, child) => AppTemplate(
          title: widget.title,
          page: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Register', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 20),
                  AppTextField(controller: usernameController, label: 'Username'),
                  const SizedBox(height: 12),
                  AppTextField(controller: emailController, label: 'Email'),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: passwordController,
                    label: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  vm.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            final user = UserModel(
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            await vm.registerUser(user);
                            if (vm.status == RegistrationStatus.success) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(vm.message!)));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginPage()),
                              );
                            } else if (vm.status == RegistrationStatus.error) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(vm.message ?? 'Error')));
                            }
                          },
                          child: vm.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Register'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
