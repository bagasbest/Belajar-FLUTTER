import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function press;

  CustomButton({@required this.text, @required this.press});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.grey[300],
      minWidth: double.infinity,
      child: ElevatedButton(
        onPressed: press,
        child: Text(text),
      ),
    );
  }
}
