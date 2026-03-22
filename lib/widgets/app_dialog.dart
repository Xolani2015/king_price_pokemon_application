import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/views/login/login_page.dart';
import 'package:king_price_pokemon_application/widgets/app_button.dart';

class AppDialog extends StatelessWidget {
  final String header;
  final String paragraph;
  final IconData sideIcon;

  const AppDialog({
    super.key,
    required this.header,
    required this.paragraph,
    required this.sideIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isDark
            ? BorderSide(color: Theme.of(context).primaryColor, width: 1)
            : BorderSide.none,
      ),
      elevation: 8,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      child: SizedBox(
        height: AppSizes(context).height * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: AppSizes(context).space.large * 2.5,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          sideIcon,
                          size: AppSizes(context).space.large,
                          color: AppColors.secondaryIcon,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          header,
                          style: TextStyle(
                            fontSize: AppSizes(context).font.medium,
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  paragraph,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: AppSizes(context).width * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 7,
                        child: AppButton(
                          height: AppSizes(context).height * 0.04,

                          text: 'Yes',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          },
                        ),
                      ),
                      Expanded(child: Container()),
                      Expanded(
                        flex: 7,
                        child: AppButton(
                          text: 'No',
                          height: AppSizes(context).height * 0.04,
                          isSecondaryButton: true,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
