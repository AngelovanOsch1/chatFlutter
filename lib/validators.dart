import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static final Validators instance = Validators._();

  List<String> splitFirstNameAndLastName(String name) {
    List<String> nameList = [];
    List<String> parts = name.split(' ');

    String firstName = parts[0];
    String lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    nameList.add(firstName);
    nameList.add(lastName);

    return nameList;
  }

  isLoading(BuildContext context) {
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
  }
}

