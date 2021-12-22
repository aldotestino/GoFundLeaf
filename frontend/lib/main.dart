import 'dart:io';

import 'package:flutter/material.dart';

import 'services/auth.dart';
import 'models/user.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                final user = await Auth.login();
                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Profile(user: user),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

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
              child: Platform.isAndroid && user.photoUrl == null
                  ? Text(
                      user.name[0].toUpperCase(),
                      style: const TextStyle(fontSize: 48),
                    )
                  : null,
              backgroundImage: Platform.isIOS
                  ? NetworkImage(user.photoUrl!)
                  : user.photoUrl != null
                      ? NetworkImage(user.photoUrl!)
                      : null,
            ),
            const SizedBox(height: 20),
            Text('${user.name} ${user.surname}'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () async {
                await Auth.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Home(),
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
