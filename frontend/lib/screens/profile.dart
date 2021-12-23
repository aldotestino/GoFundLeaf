import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofundleaf/models/user.dart';
import 'package:gofundleaf/screens/home.dart';
import 'package:gofundleaf/services/auth_service.dart';
import 'package:gofundleaf/services/donate_service.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _user;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilo'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 50,
                child: Platform.isAndroid && _user?.photoUrl == null
                    ? Text(
                        widget.user.name[0].toUpperCase(),
                        style: const TextStyle(fontSize: 48),
                      )
                    : null,
                backgroundImage: Platform.isIOS
                    ? NetworkImage(widget.user.photoUrl!)
                    : widget.user.photoUrl != null
                        ? NetworkImage(_user!.photoUrl!)
                        : null,
              ),
              const SizedBox(height: 10),
              Text(
                '${widget.user.name} ${widget.user.surname}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Logout'),
                onPressed: () async {
                  await AuthService.logout();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
              ),
              ElevatedButton(
                  child: const Text('Dona con PayPal'),
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    final ds = await DonateService.donate(_user!.googleId);
                    _user!.donations = ds;
                    setState(() {
                      _loading = false;
                    });
                  }),
              const SizedBox(height: 20),
              Text(
                widget.user.donations.isNotEmpty
                    ? 'Donazioni recenti'
                    : 'Effettua una donazione',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _loading
                    ? const CupertinoActivityIndicator()
                    : ListView.separated(
                        itemCount: widget.user.donations.length,
                        separatorBuilder: (context, index) => const Divider(
                            thickness: 2,
                            color: Color.fromARGB(255, 206, 206, 206)),
                        itemBuilder: (context, index) => ListTile(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '€ ${widget.user.donations[index].amt.toStringAsFixed(2)}', // user.donations.length - index - 1 per visualizzare la donazione più recente per prima
                                  style: const TextStyle(fontSize: 30),
                                ),
                                Text(
                                  widget.user.donations[index].date,
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
