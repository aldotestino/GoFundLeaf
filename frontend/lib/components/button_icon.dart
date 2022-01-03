import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function() action;
  const ButtonIcon(
      {Key? key, required this.label, required this.icon, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.green),
        primary: Colors.green,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      ),
      onPressed: action,
      icon: FaIcon(
        icon,
      ),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}
