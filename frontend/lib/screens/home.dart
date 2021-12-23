import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofundleaf/screens/profile.dart';
import 'package:gofundleaf/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoFundLeaf')),
      body: Center(
        child: _loading
            ? const CupertinoActivityIndicator()
            : ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
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
                },
              ),
      ),
    );
  }
}
