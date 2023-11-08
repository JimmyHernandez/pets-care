import 'package:flutter/cupertino.dart';

class CareListItem extends StatelessWidget {
  final String text;

  const CareListItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            '\u2022', // Bullet point character
            style: TextStyle(
              color: Color(0xFF6F35A5),
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(text, style: const TextStyle(
            color: Color(0xFF6F35A5),
            fontSize: 16,
          ),),
        ),
      ],
    );
  }
}