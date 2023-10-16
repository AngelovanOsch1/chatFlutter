import 'dart:io';

import 'package:chatapp/colors.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/validators.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final double coverHeight = 150;
  final double profileHeight = 144;

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _bio = TextEditingController();
  final _telephoneNumber = TextEditingController();
  final _country = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _bio.dispose();
    _telephoneNumber.dispose();
    _country.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  File? _profilePhoto;
  File? _bannerPhoto;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModelProvider>(context).userData;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Change profile',
          style: textTheme.headlineLarge!.copyWith(fontSize: 25),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          bannerAndProfilePhoto(userModel),
          profileInformation(userModel),
        ],
      ),
    );
  }

  Widget bannerAndProfilePhoto(UserModel userModel) {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: banner(userModel),
        ),
        Positioned(
          top: top,
          child: profilePhoto(userModel),
        ),
      ],
    );
  }

  Widget banner(UserModel userModel) {
    return Stack(
      children: [
        userModel.banner.isEmpty && _bannerPhoto == null
            ? Image.network(
                'https://wildeanalysis.co.uk/wp-content/uploads/2015/09/df-banner-placeholder.png',
                width: double.infinity,
                height: coverHeight,
                fit: BoxFit.cover,
              )
            : userModel.banner.isEmpty && _bannerPhoto != null
                ? Image.file(
                    _bannerPhoto!,
                    width: double.infinity,
                    height: coverHeight,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    userModel.banner,
                    width: double.infinity,
                    height: coverHeight,
                    fit: BoxFit.cover,
                  ),
        Positioned(
          top: 0,
          right: 20,
          child: Container(
            width: 30,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                _pickBannerPhoto(ImageSource.gallery);
              },
              icon: const Icon(
                Icons.create,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickBannerPhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(
      () {
        if (pickedFile != null) {
          _bannerPhoto = File(pickedFile.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This image is not supported'),
            ),
          );
        }
      },
    );
  }

  Widget profilePhoto(UserModel userModel) {
    return Stack(
      children: [
        CircleAvatar(
          radius: profileHeight / 2,
          backgroundColor: Colors.grey.shade800,
          backgroundImage: _profilePhoto == null ? NetworkImage(userModel.profilePhoto) : null,
          child: userModel.profilePhoto.isEmpty && _profilePhoto == null
              ? Text(
                  userModel.name[0],
                  style: textTheme.headlineLarge!.copyWith(fontSize: 100),
                )
              : ClipOval(
                  child: SizedBox(
                    width: profileHeight,
                    height: profileHeight,
                    child: _profilePhoto == null
                        ? null
                        : Image.file(
                            _profilePhoto!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
        ),
        Positioned(
          top: 100,
          right: 10,
          child: Container(
            width: 30,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                _pickProfilePhoto(ImageSource.gallery);
              },
              icon: const Icon(
                Icons.create,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickProfilePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(
      () {
        if (pickedFile != null) {
          _profilePhoto = File(pickedFile.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This image is not supported'),
            ),
          );
        }
      },
    );
  }

  Widget profileInformation(UserModel userModel) {
    List<String> name = Validators.instance.splitFirstNameAndLastName(userModel.name);
    _firstName.text = name[0];
    _lastName.text = name[1];
    _bio.text = userModel.bio;
    _telephoneNumber.text = userModel.telephoneNumber;
    _country.text = userModel.country;

    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 50),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First name',
                        style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _firstName,
                          cursorColor: colorScheme.onBackground,
                          style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'First name',
                            hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 40),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last name',
                        style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _lastName,
                          cursorColor: colorScheme.onBackground,
                          style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Last name',
                            hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Bio',
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
              ),
            ),
            TextFormField(
              controller: _bio,
              maxLines: 5,
              cursorColor: colorScheme.onBackground,
              style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Bio',
                hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Phone number',
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
              ),
            ),
            TextFormField(
              controller: _telephoneNumber,
              cursorColor: colorScheme.onBackground,
              style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Country',
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
              ),
            ),
            TextFormField(
              controller: _country,
              cursorColor: colorScheme.onBackground,
              style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Country',
                hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextButton(
                onPressed: () {
                  saveProfile(userModel);
                },
                child: Text(
                  'Save',
                  style: textTheme.headlineLarge!.copyWith(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveProfile(UserModel userModel) async {
    final Reference profilePhotoDirectory = FirebaseStorage.instance.ref().child('user_data/${userModel.uid}/images/profile_photo/profile_photo');
    final Reference bannerDirectory = FirebaseStorage.instance.ref().child('user_data/${userModel.uid}/images/banner_photo/banner_photo');

    await profilePhotoDirectory.putFile(_profilePhoto!);
    final TaskSnapshot uploadTask = await profilePhotoDirectory.putFile(_profilePhoto!);
    final String profilePhoto = await uploadTask.ref.getDownloadURL();

    await bannerDirectory.putFile(_bannerPhoto!);
    final TaskSnapshot uploadTask123 = await bannerDirectory.putFile(_bannerPhoto!);
    final String banner = await uploadTask123.ref.getDownloadURL();
  }
}
