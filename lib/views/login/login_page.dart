import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/user_model.dart';
import 'package:king_price_pokemon_application/views/pokemonList/pokemon_list_page.dart';
import 'package:king_price_pokemon_application/views/login/login_viewmodel.dart';
import 'package:king_price_pokemon_application/views/registration/registration_page.dart';
import 'package:king_price_pokemon_application/widgets/app_button.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:king_price_pokemon_application/widgets/app_textfield.dart';
import 'package:king_price_pokemon_application/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, vm, child) => AppTemplate(
          title: 'log In',
          currentPage: AppPage.login,
          isShowTopBar: true,
          showFloatingActionButton: true,
          page: SingleChildScrollView(
            padding: kIsWeb
                ? EdgeInsets.symmetric(horizontal: AppSizes(context).padding.large * 4)
                : const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOG IN',
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
                  'Enter your credentials to access your account',
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
                  height: kIsWeb ? AppSizes(context).space.small : AppSizes(context).space.xxsmall,
                ),
                AppTextField(controller: emailController, label: 'Email'),
                SizedBox(
                  height: kIsWeb
                      ? AppSizes(context).space.xxsmall * 0.5
                      : AppSizes(context).space.xxsmall * 0.5,
                ),
                AppTextField(controller: passwordController, label: 'Password', obscureText: true),
                SizedBox(
                  height: kIsWeb ? AppSizes(context).space.small : AppSizes(context).space.xxsmall,
                ),
                AppButton(
                  text: 'LOG IN',
                  isLoading: vm.isLoading,
                  onPressed: () async {
                    final user = UserModel(
                      username: '',
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    await vm.login(user);
                    if (vm.status == LoginStatus.success) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(vm.message!)));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const PokemonListPage()),
                      );
                    } else if (vm.status == LoginStatus.error) {
                      showErrorToast(context, vm.message ?? 'Registration Failed');
                    }
                  },
                ),
                SizedBox(
                  height: kIsWeb
                      ? AppSizes(context).space.small * 0.4
                      : AppSizes(context).space.xxsmall * 0.5,
                ),
                AppButton(
                  text: 'REGISTER',
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
      ),
    );
  }
}
