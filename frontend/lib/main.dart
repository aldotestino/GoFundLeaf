import 'package:flutter/material.dart';
import 'package:gofundleaf/screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 245, 245, 245),
            shadowColor: Colors.transparent,
            foregroundColor: Colors.black),
      ),
      home: const Home(),
    );
  }
}
