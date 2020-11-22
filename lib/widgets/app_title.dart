import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
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
    );
  }
}
