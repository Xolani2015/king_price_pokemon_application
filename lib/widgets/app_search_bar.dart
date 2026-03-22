import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';

class AnimatedSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const AnimatedSearchBar({super.key, required this.onChanged});

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.searchTextAndBorder, width: 2),
      ),

      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.searchTextAndBorder),
          const SizedBox(width: 8),
          Expanded(
            child: Focus(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Pokémon...',
                  hintStyle: TextStyle(color: AppColors.searchTextAndBorder),
                  border: InputBorder.none,
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                widget.onChanged('');
                setState(() {});
              },
              child: const Icon(Icons.close, color: Colors.redAccent),
            ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.searchTextAndBorder),
            onPressed: () {
              //TODO: Maby I can clear the text here at some point
            },
          ),
        ],
      ),
    );
  }
}
