import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colorScheme.background,
      content: const SizedBox(
        height: 400,
        child: Column(
          children: [
            Text('test'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
