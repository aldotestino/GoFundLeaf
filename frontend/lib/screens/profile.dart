import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofundleaf/components/avatar.dart';
import 'package:gofundleaf/components/background_container.dart';
import 'package:gofundleaf/components/button_icon.dart';
import 'package:gofundleaf/components/donations_list.dart';
import 'package:gofundleaf/models/user.dart';
import 'package:gofundleaf/screens/home.dart';
import 'package:gofundleaf/services/auth_service.dart';
import 'package:gofundleaf/services/donate_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gofundleaf/services/notification_service.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User _user;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    NotificationService.init();
    _user = widget.user;
  }

  void handleDonate() async {
    setState(() {
      _loading = true;
    });
    final ds =
        await DonateService.donate(_user.googleId, _user.donations.length);
    _user.donations = ds;
    setState(() {
      _loading = false;
    });
  }

  void handleLogout() async {
    await AuthService.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void handledelete() async {
    final deleted = await AuthService.deleteProfile(_user.googleId);
    final snackBar = SnackBar(
      content: Text(
        deleted
            ? 'Profilo eliminato con successo'
            : 'Si è verificato un errore',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/small.png'),
                  const SizedBox(width: 10),
                  const Text('GoFundLeaf')
                ],
              ),
              PopupMenuButton(
                icon: const Icon(Icons.menu),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Logout'),
                    value: 'logout',
                    onTap: handleLogout,
                  ),
                  PopupMenuItem(
                    child: const Text(
                      'Elimina profilo',
                      style: TextStyle(color: Colors.red),
                    ),
                    value: 'delete_profile',
                    onTap: handledelete,
                  )
                ],
              )
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
                Avatar(name: _user.name, photoUrl: _user.photoUrl),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Benvenuto ${_user.name}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    ButtonIcon(
                      label: 'Dona con PayPal',
                      icon: FontAwesomeIcons.paypal,
                      action: handleDonate,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              _user.donations.isNotEmpty
                  ? 'Donazioni recenti'
                  : 'Effettua una donazione',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              child: _loading
                  ? const CupertinoActivityIndicator()
                  : Expanded(child: DonationList(donations: _user.donations)),
            ),
          ],
        ),
      ),
    );
  }
}
