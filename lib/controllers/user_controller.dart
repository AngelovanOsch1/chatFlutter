import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserModelController {
  late final BuildContext context;

  UserModelController(this.context);

  Stream<List<UserModel>> getUsersStream() {
    return context.read<Repository>().getUserCollection.snapshots().map((snapshot) {
      return snapshot.docs.where((doc) => doc.id != context.read<Repository>().getAuth.currentUser?.uid).map((doc) {
        return UserModel.constructFromSnapshot(doc);
      }).toList();
    });
  }
}
