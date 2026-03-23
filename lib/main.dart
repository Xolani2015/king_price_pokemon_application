import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/provider/provider_store.dart';
import 'package:king_price_pokemon_application/views/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA98IHgPLxKvUmzPeQrTPWNMOZXxy2CHxg",
        authDomain: "king-price-pokemon-application.firebaseapp.com",
        projectId: "king-price-pokemon-application",
        storageBucket: "king-price-pokemon-application.appspot.com",
        messagingSenderId: "158232182248",
        appId: "1:158232182248:web:b684ece242fd29cb37f85d",
        measurementId: "G-HB2MBMK2HZ",
      ),
    );
  } else {
    await Firebase.initializeApp(); // mobile auto-config
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PokemonStore()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'King Price Pokémon',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashPage(),
        );
      },
    );
  }
}
