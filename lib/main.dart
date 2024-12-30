import 'package:flutter/material.dart';
import 'package:mis_labs2/screens/joke_types.dart';
import 'package:provider/provider.dart';
import 'package:mis_labs2/providers/favorite_jokes_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/notif_service.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteJokesProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: const JokeTypesScreen(),
    );
  }
}