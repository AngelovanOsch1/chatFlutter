import 'package:chatapp/colors.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static final Validators instance = Validators._();

  String? Function(String?)? emptyOrNullValue(String? value, BuildContext context) {
    // if (value == null || value.isEmpty) {
    //   return (String? input) => AppLocalizations.of(context).emptyValueError;
    // }
    // return (String? input) => null;
  }


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

