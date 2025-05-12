import 'package:example/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flux/flux.dart';

void main() async {
  await Flux.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Flux.config.theme,
      home: const MyHomePage(),
    );
  }
}
