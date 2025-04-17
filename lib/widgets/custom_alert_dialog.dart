import 'package:flutter/material.dart';
import 'package:todoapp/widgets/custom_material_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget content;
  final void Function() onPressed;
  const CustomAlertDialog({
    super.key,
    required this.onPressed,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Item'),
      shape: LinearBorder(),
      backgroundColor: Colors.yellow.shade200,
      content: content,
      actions: [
        CustomMaterialButton(text: 'Save', onPressed: onPressed),
        CustomMaterialButton(
          text: 'Cancel',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
