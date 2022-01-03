import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget? child;
  const BackgroundContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/waves.png'),
            alignment: Alignment.bottomCenter),
      ),
      child: child,
    );
  }
}
