import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/widgets/app_custom_to_bar.dart';


class AppTemplate extends StatefulWidget {
  const AppTemplate({
    super.key,
    required this.title,
    required this.page,
    this.isShowTopBar = false,
  });

  final String title;
  final Widget page;
  final bool isShowTopBar;
  @override
  State<AppTemplate> createState() => _AppTemplateState();
}

class _AppTemplateState extends State<AppTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isShowTopBar == true
          ? AppCustomTopBar(
              isHomePage: true,
              logoPath: 'assets/branding/app_logo.webp',
              onMenuTap: () {},
              onActionTap: () {},
            )
          : null,
      body: Padding(
        padding: AppSizes(context).padding.medium,
        child: widget.page,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}