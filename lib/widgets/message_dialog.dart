import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lya_encuestas/widgets/custom_buttom.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<VoidCallback>? lstButtonCallback;
  final List<String>? lstButtonTittles;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  MessageDialog({
    required this.title,
    required this.message,
    this.lstButtonCallback,
    this.lstButtonTittles,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = <Widget>[];
    if (lstButtonCallback != null && lstButtonTittles != null) {
      for (var i = 0; i < lstButtonCallback!.length; i++) {
        buttons.add(CustomButton(
            title: lstButtonTittles![i], onPressed: lstButtonCallback![i]));
      }
    }

    return SimpleDialog(
      title: Center(child: Text(title)),
      children: <Widget>[
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Text(message),
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(children: buttons),
        ),
      ],
    );
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          context;
          return MessageDialog(
              title: title,
              message: message,
              lstButtonCallback: lstButtonCallback,
              lstButtonTittles: lstButtonTittles);
        });
  }
}
