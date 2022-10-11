import 'package:flutter/material.dart';
import 'package:tiki_app/home_page.dart';
import 'package:provider/provider.dart';
import 'package:tiki_app/provider/provider_cart.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Cart(),
    child: const MaterialApp(
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}
