import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/validators.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = Provider.of<UserModelProvider>(context, listen: false).userData;

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: colorScheme.background,
      buttonPadding: const EdgeInsets.only(left: 50),
      icon: const Icon(
        Icons.warning_amber_outlined,
        size: 80,
        color: Colors.red,
      ),
      title: Text(
        'Are you sure that you want to delete your account? All data will be deleted and lost forever',
        style: textTheme.headlineMedium!.copyWith(fontSize: 16),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(
              (states) => const EdgeInsets.only(left: 10, right: 10),
            ),
            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'no',
            style: textTheme.headlineMedium!.copyWith(fontSize: 12),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(
              (states) => const EdgeInsets.only(left: 10, right: 10),
            ),
            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          onPressed: () async {
            Validators.instance.isLoading(context, true);
            await deleteAccount(context, userModel);
            Validators.instance.isLoading(context, false);
          },
          child: Text(
            'Yes',
            style: textTheme.headlineMedium!.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }

  deleteAccount(BuildContext context, UserModel userModel) async {
    final String userModelId = userModel.id;
    HttpsCallable callable = context.read<Repository>().cloudFunction.httpsCallable('deleteAccount');

    try {
      HttpsCallableResult<dynamic> response = await callable.call(userModelId);
      if (response.data['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thank you for using my app!'),
          ),
        );
        Future.delayed(
          const Duration(seconds: 4),
        );
        await context.read<Repository>().getAuth.signOut();
        Phoenix.rebirth(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).oopsMessage),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).oopsMessage),
        ),
      );
    }
  }
}
