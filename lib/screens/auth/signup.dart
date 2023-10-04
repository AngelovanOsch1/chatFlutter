import 'dart:io';
import 'dart:typed_data';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repeatPassword = TextEditingController();

  bool _passwordVisible = true;
  bool _repeatPasswordVisible = true;

  File? _imageFile;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80, right: 30, left: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                ),
                _buildImagePicker(),
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _firstName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'First name',
                            labelText: 'First name',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 30),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _lastName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Last name',
                            labelText: 'Last name',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: _password,
                    obscureText: _passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              _passwordVisible = !_passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: _repeatPassword,
                    obscureText: _repeatPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Repeat password',
                      labelText: 'Repeat password',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(_repeatPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              _repeatPasswordVisible = !_repeatPasswordVisible;
                            },
                          );
                        },
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextButton(
                    onPressed: () {
                      _register(context);
                    },
                    child: const Text('Signup'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: <Widget>[
        if (_imageFile != null) ...[
          Image.file(
            _imageFile!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
        ],
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.gallery),
          child: const Text('Pick an Image'),
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String firstName = _firstName.text.trim();
    final String lastName = _lastName.text.trim();
    final String email = _email.text.trim();
    final String password = _password.text.trim();
    final String repeatPassword = _repeatPassword.text.trim();
    String storageLocation = '';

    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
        ),
      );
      return;
    }

    UserCredential? userCredential =
        await FirebaseFunction.instance.createUser(context, email, password);

    if (userCredential != null) {
      final String uid = userCredential.user?.uid ?? '';

      final Reference userDirectory = FirebaseStorage.instance
          .ref()
          .child('user_data/$uid/images/profile_photo/profile_photo');

      try {
        await userDirectory.putFile(_imageFile!);
        final TaskSnapshot uploadTask =
            await userDirectory.putFile(_imageFile!);
        storageLocation = await uploadTask.ref.getDownloadURL();
        print('Image uploaded successfully.');
      } catch (e) {
        print('Error uploading image: $e');
      }
  
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users.doc(userCredential.user?.uid).set({
        'name': '$firstName $lastName',
        'email': email,
        'profilePhoto': storageLocation,         
      });
    } else {
      debugPrint('ERROR: Signup account: ${userCredential.toString()}');
    }
  }
}
