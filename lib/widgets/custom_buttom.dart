import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Gradient style;
  final double buttonWidth;
  final double buttonHeight;

  // ignore: constant_identifier_names
  static const Gradient STYLE_NORMAL = LinearGradient(colors: [
    Color.fromARGB(200, 34, 93, 255),
    Color.fromARGB(200, 50, 151, 24)
  ]);
  // ignore: constant_identifier_names
  static const Gradient STYLE_ACTIVE = LinearGradient(colors: [
    Color.fromARGB(200, 224, 147, 4),
    Color.fromARGB(200, 151, 24, 24)
  ]);

  static const Gradient STYLE_NEW = LinearGradient(colors: [
    Color.fromARGB(200, 0, 0, 0),
    Color.fromARGB(200, 3, 3, 3)
  ]);
  static const Gradient STYLE_LIQUID = LinearGradient(colors: [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 0, 0)
  ]);
  // ignore: constant_identifier_names
  static const Gradient STYLE_INACTIVE = LinearGradient(
      colors: [Color.fromARGB(100, 83, 83, 83), Color.fromARGB(167, 0, 0, 0)]);

  CustomButton(
      {required this.title,
      required this.onPressed,
      this.style = CustomButton.STYLE_NEW,
      this.buttonWidth = 0,
      this.buttonHeight = 0});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Constants.COLOR_BACKGROUND),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0))),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: (buttonWidth == 0 ? size.width * 0.5 : buttonWidth),
        height: (buttonHeight == 0 ? 40.0 : buttonHeight),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0), gradient: style),
        padding: const EdgeInsets.all(8),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
    );
  }
}
