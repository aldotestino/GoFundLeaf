import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gofundleaf/google_signin_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoFundLeaf')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                final googleUser = await GoogleSignInApi.login();
                print(googleUser);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Profilo(
                        email: googleUser!.email,
                        photoUrl: googleUser.photoUrl),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Profilo extends StatelessWidget {
  final String email;
  final String? photoUrl;
  const Profilo({Key? key, required this.email, required this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilo'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Platform.isAndroid && photoUrl == null
                  ? Text(
                      email[0].toUpperCase(),
                      style: const TextStyle(fontSize: 48),
                    )
                  : null,
              backgroundImage: Platform.isIOS
                  ? NetworkImage(photoUrl!)
                  : photoUrl != null
                      ? NetworkImage(photoUrl!)
                      : null,
            ),
            const SizedBox(height: 20),
            Text(email),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () async {
                await GoogleSignInApi.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
