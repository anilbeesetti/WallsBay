import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showAboutDialog(
          context: context,
          applicationVersion: '1.0.0',
          applicationIcon: FlutterLogo(
            size: 40,
          ),
          children: [
            Text(
              'CodeInit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text('Developer: '),
                Text('Anil Beesetti'),
              ],
            ),
          ],
        );
        HapticFeedback.mediumImpact();
      },
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          children: [
            TextSpan(
              text: 'Walls',
              style: TextStyle(color: Colors.black87, fontFamily: 'Lato'),
            ),
            TextSpan(
              text: 'Bay',
              style: TextStyle(color: Colors.blue, fontFamily: 'Lato'),
            ),
          ],
        ),
      ),
    );
  }
}
