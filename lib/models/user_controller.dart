import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserModelController {
  final BuildContext context;

  UserModelController(this.context);

  Stream<List<UserModel>> getUsersStream() {
    return context.read<Repository>().getCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.constructFromSnapshot(doc);
      }).toList();
    });
  }
}
