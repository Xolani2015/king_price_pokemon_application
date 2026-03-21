// pages/registration_page.dart
import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/user_model.dart';
import 'package:king_price_pokemon_application/views/login/login_page.dart';
import 'package:king_price_pokemon_application/views/registration/registration_viewmodel.dart';
import 'package:king_price_pokemon_application/widgets/app_button.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:king_price_pokemon_application/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrationViewModel(),
      child: Consumer<RegistrationViewModel>(
        builder: (context, vm, child) => AppTemplate(
          title: 'Register',
          showFloatingActionButton: true,
          isShowTopBar: true,
          hasBack: true,
          page: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: AppSizes(context).font.large,
                    color: const Color.fromARGB(255, 184, 184, 184),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSizes(context).space.medium),
                Text(
                  'Enter your details to create an account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSizes(context).font.medium,
                    color: const Color.fromARGB(255, 184, 184, 184),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: AppSizes(context).space.medium),
                AppTextField(
                  controller: usernameController,
                  label: 'Name',
                  errorText: vm.fieldErrors['username'],
                ),
                SizedBox(height: AppSizes(context).space.medium),
                AppTextField(
                  controller: emailController,
                  label: 'Email',
                  errorText: vm.fieldErrors['email'],
                ),
                SizedBox(height: AppSizes(context).space.medium),
                AppTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                  errorText: vm.fieldErrors['password'],
                ),
                SizedBox(height: AppSizes(context).space.medium),
                AppTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: true,
                  errorText: vm.fieldErrors['confirmPassword'],
                ),
                SizedBox(height: AppSizes(context).space.large),
                AppButton(
                  text: 'REGISTER',
                  isLoading: vm.isLoading,
                  onPressed: () async {
                    final user = UserModel(
                      username: usernameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );

                    final errors = vm.validateUser(user, confirmPasswordController.text);

                    if (errors.isNotEmpty) {
                      return;
                    }
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
