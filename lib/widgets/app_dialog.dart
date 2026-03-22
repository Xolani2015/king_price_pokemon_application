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
        height: AppSizes(context).height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: AppSizes(context).space.large * 3,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(sideIcon, size: 40, color: AppColors.secondaryIcon),
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    paragraph,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: (AppSizes(context).padding.medium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 7,
                        child: AppButton(
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
