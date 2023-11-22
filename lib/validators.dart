import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static final Validators instance = Validators._();

  List<String> splitFirstNameAndLastName(String name) {
    final List<String> nameList = [];
    final List<String> parts = name.split(' ');

    final String firstName = parts[0];
    final String lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    nameList.add(firstName);
    nameList.add(lastName);

    return nameList;
  }

void isLoading(BuildContext context, bool enable) {
    if (enable) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 60,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: colorScheme.onBackground,
                color: colorScheme.primary,
                value: 0.5,
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}

