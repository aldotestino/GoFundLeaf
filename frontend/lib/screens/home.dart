import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofundleaf/components/background_container.dart';
import 'package:gofundleaf/screens/profile.dart';
import 'package:gofundleaf/services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gofundleaf/components/button_icon.dart';
import 'package:gofundleaf/services/notification_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;

  void handleLogin() async {
    setState(() {
      _loading = true;
    });
    final user = await AuthService.login();
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Profile(user: user),
        ),
      );
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Image.asset('assets/images/small.png'),
              const SizedBox(width: 10),
              const Text('GoFundLeaf')
            ],
          ),
        ),
      ),
      body: BackgroundContainer(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Image.asset(
                  'assets/images/big.png',
                  width: 100,
                ),
                const SizedBox(width: 20),
                const Text(
                  'L\'agricoltura\nnon è mai stata\ncosì semplice!',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              child: _loading
                  ? const CupertinoActivityIndicator()
                  : ButtonIcon(
                      label: 'Entra con Google',
                      icon: FontAwesomeIcons.google,
                      action: handleLogin,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
