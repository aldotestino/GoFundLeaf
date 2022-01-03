import 'dart:io';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? photoUrl;
  final String name;
  const Avatar({Key? key, this.photoUrl, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      child: Platform.isAndroid && photoUrl == null
          ? Text(
              name[0].toUpperCase(),
              style: const TextStyle(fontSize: 48),
            )
          : null,
      backgroundImage: Platform.isIOS
          ? NetworkImage(photoUrl!)
          : photoUrl != null
              ? NetworkImage(photoUrl!)
              : null,
    );
  }
}
