import 'dart:async';
import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';

class AppCoursel extends StatefulWidget {
  const AppCoursel({super.key});

  @override
  State<AppCoursel> createState() => _AppCourselState();
}

class _AppCourselState extends State<AppCoursel> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> items = [
    {
      'header': 'Catch Pokémon',
      'paragraph': 'Explore the world and catch your favorite Pokémon.',
      'image': 'assets/images/pokemon1.webp',
    },
    {
      'header': 'Train Hard',
      'paragraph': 'Level up your Pokémon and prepare for battles.',
      'image': 'assets/images/pokemon2.webp',
    },
    {
      'header': 'Battle Friends',
      'paragraph': 'Challenge your friends and prove your skills.',
      'image': 'assets/images/pokemon3.webp',
    },
    {
      'header': 'Become a Champion',
      'paragraph': 'Win tournaments and become the ultimate Pokémon master.',
      'image': 'assets/images/pokemon4.webp',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < items.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_controller.hasClients) {
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PageView.builder(
      controller: _controller,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['header'] ?? '',
                  style: TextStyle(
                    fontSize: AppSizes(context).font.large,
                    color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSizes(context).space.medium),
                Text(
                  item['paragraph'] ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSizes(context).font.medium,
                    color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                  ),
                ),
                if (item['image'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Image.asset(
                      item['image']!,
                      height: AppSizes(context).space.xxlarge,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
