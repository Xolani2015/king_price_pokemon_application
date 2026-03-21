import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/user_model.dart';
import 'package:king_price_pokemon_application/views/login/login_viewmodel.dart';
import 'package:king_price_pokemon_application/widgets/app_button.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:king_price_pokemon_application/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

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
          isShowTopBar: true,
          hasBack: true,
          showFloatingActionButton: true,
          page: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOG IN',
                  style: TextStyle(
                    fontSize: AppSizes(context).font.large,
                    color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSizes(context).space.medium),
                Text(
                  'Enter your credentials to access your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSizes(context).font.medium,
                    color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: AppSizes(context).space.medium),
                AppTextField(controller: emailController, label: 'Email'),
                SizedBox(height: AppSizes(context).space.small),
                AppTextField(controller: passwordController, label: 'Password', obscureText: true),
                SizedBox(height: AppSizes(context).space.large),

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
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    } else if (vm.status == LoginStatus.error) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(vm.message!)));
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
