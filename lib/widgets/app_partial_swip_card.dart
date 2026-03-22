import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/provider/provider_store.dart';
import 'package:provider/provider.dart';

class AppPartialSwipCard extends StatefulWidget {
  final PokemonModel poke;

  const AppPartialSwipCard({super.key, required this.poke});

  @override
  State<AppPartialSwipCard> createState() => _AppPartialSwipCardState();
}

class _AppPartialSwipCardState extends State<AppPartialSwipCard> {
  double _offset = 0.0;
  bool _isOpen = false;

  void _toggleOpen() {
    setState(() {
      _isOpen = !_isOpen;
      _offset = _isOpen ? -80.0 : 0.0; // ~25% of typical card width
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PokemonStore>(context, listen: false);

    return Stack(
      children: [
        // Background with Remove button
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  store.removeFavourite(widget.poke);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.poke.name} removed from favourites')),
                  );
                  _toggleOpen();
                },
                child: const Text('Remove', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
        // Foreground card
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.primaryDelta != null) {
              setState(() {
                _offset += details.primaryDelta!;
                if (_offset < -80) _offset = -80;
                if (_offset > 0) _offset = 0;
              });
            }
          },
          onHorizontalDragEnd: (_) {
            if (_offset < -40) {
              _isOpen = true;
              _offset = -80;
            } else {
              _isOpen = false;
              _offset = 0;
            }
            setState(() {});
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(_offset, 0, 0),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: widget.poke.image.isNotEmpty
                    ? Image.network(widget.poke.image, height: 40, fit: BoxFit.contain)
                    : const Icon(Icons.catching_pokemon),
                title: Text(widget.poke.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
