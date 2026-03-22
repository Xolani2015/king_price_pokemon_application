// pages/registration_page.dart
import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/user_model.dart';
import 'package:king_price_pokemon_application/views/login/login_page.dart';
import 'package:king_price_pokemon_application/views/registration/registration_viewmodel.dart';
import 'package:king_price_pokemon_application/widgets/app_button.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:king_price_pokemon_application/widgets/app_textfield.dart';
import 'package:king_price_pokemon_application/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ChangeNotifierProvider(
      create: (_) => RegistrationViewModel(),
      child: Consumer<RegistrationViewModel>(
        builder: (context, vm, child) => AppTemplate(
          title: 'Register',
          currentPage: AppPage.registration,
          showFloatingActionButton: true,
          isShowTopBar: true,
          hasBack: true,
          page: SingleChildScrollView(
            child: Padding(
              padding: kIsWeb
                  ? EdgeInsets.symmetric(horizontal: AppSizes(context).padding.large * 4)
                  : const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: kIsWeb
                          ? AppSizes(context).font.large * 1.3
                          : AppSizes(context).font.large,
                      color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: kIsWeb
                        ? AppSizes(context).space.small * 0.1
                        : AppSizes(context).space.small * 0.5,
                  ),
                  Text(
                    'Enter your details to create an account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: kIsWeb
                          ? AppSizes(context).font.medium * 1.3
                          : AppSizes(context).font.medium,
                      color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: kIsWeb
                        ? AppSizes(context).space.small
                        : AppSizes(context).space.xxsmall,
                  ),
                  AppTextField(
                    controller: usernameController,
                    label: 'Name',
                    errorText: vm.fieldErrors['username'],
                  ),
                  SizedBox(
                    height: kIsWeb
                        ? AppSizes(context).space.xxsmall * 0.5
                        : AppSizes(context).space.xxsmall * 0.5,
                  ),
                  AppTextField(
                    controller: emailController,
                    label: 'Email',
                    errorText: vm.fieldErrors['email'],
                  ),
                  SizedBox(
                    height: kIsWeb
                        ? AppSizes(context).space.xxsmall * 0.5
                        : AppSizes(context).space.xxsmall * 0.5,
                  ),
                  AppTextField(
                    controller: passwordController,
                    label: 'Password',
                    obscureText: true,
                    errorText: vm.fieldErrors['password'],
                  ),
                  SizedBox(
                    height: kIsWeb
                        ? AppSizes(context).space.xxsmall * 0.5
                        : AppSizes(context).space.xxsmall * 0.5,
                  ),
                  AppTextField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    obscureText: true,
                    errorText: vm.fieldErrors['confirmPassword'],
                  ),
                  SizedBox(
                    height: kIsWeb
                        ? AppSizes(context).space.small
                        : AppSizes(context).space.xxsmall,
                  ),
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
                        showSuccessToast(context, vm.message ?? 'Registration Successful!');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      } else if (vm.status == RegistrationStatus.error) {
                        showErrorToast(context, vm.message ?? 'Registration Failed');
                      }
                    },
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
