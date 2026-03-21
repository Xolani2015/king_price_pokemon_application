import 'dart:async';
import 'package:flutter/material.dart';

class AppCoursel extends StatefulWidget {
  const AppCoursel({super.key});

  @override
  State<AppCoursel> createState() => _AppCourselState();
}

class _AppCourselState extends State<AppCoursel> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> images = [
    'assets/images/pokemon1.webp',
    'assets/images/pokemon2.webp',
    'assets/images/pokemon3.webp',
    'assets/images/pokemon4.webp',
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
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
    return PageView.builder(
      controller: _controller,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(images[index], fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
