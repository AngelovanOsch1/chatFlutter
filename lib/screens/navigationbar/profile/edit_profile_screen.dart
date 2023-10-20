import 'dart:io';
import 'package:chatapp/colors.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  File? _banner;

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
          AppLocalizations.of(context).changeProfile,
          style: textTheme.headlineLarge!.copyWith(fontSize: 25),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          bannerAndProfilePhoto(userModel),
          profileInformation(context, userModel),
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
        userModel.banner.isEmpty && _banner == null
            ? Container(
                color: Colors.grey,
                width: double.infinity,
                height: coverHeight,
              )
            : Container(
                child: _banner == null
                    ? Image.network(
                        userModel.banner,
                        width: double.infinity,
                        height: coverHeight,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        _banner!,
                        width: double.infinity,
                        height: coverHeight,
                        fit: BoxFit.cover,
                      ),
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
          _banner = File(pickedFile.path);
        }
      },
    );
  }

  Widget profilePhoto(UserModel userModel) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.background,
              width: 10,
            ),
          ),
          child: userModel.profilePhoto.isEmpty && _profilePhoto == null
              ? ProfilePhoto(userModel.profilePhoto, userModel.name, userModel.isOnline, 'myProfilePhoto')
              : ClipOval(
                  child: _profilePhoto == null
                      ? ProfilePhoto(userModel.profilePhoto, userModel.name, userModel.isOnline, 'myProfilePhoto')
                      : CircleAvatar(
                          radius: profileHeight / 2,
                          backgroundColor: Colors.grey.shade800,
                          child: Image.file(
                            _profilePhoto!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: coverHeight,
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
        }
      },
    );
  }

  Widget profileInformation(BuildContext context, UserModel userModel) {
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
                        AppLocalizations.of(context).firstName,
                        style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _firstName,
                          cursorColor: colorScheme.onBackground,
                          style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                          validator: Validators.instance.emptyOrNullValue('', context),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).firstName,
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
                        AppLocalizations.of(context).lastName,
                        style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _lastName,
                          cursorColor: colorScheme.onBackground,
                          style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                          validator: Validators.instance.emptyOrNullValue('', context),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).lastName,
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
                AppLocalizations.of(context).userBio,
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
              ),
            ),
            TextFormField(
              controller: _bio,
              maxLines: 5,
              cursorColor: colorScheme.onBackground,
              style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).userBio,
                hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                AppLocalizations.of(context).phoneNumber,
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
              ),
            ),
            TextFormField(
              controller: _telephoneNumber,
              cursorColor: colorScheme.onBackground,
              style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              validator: Validators.instance.emptyOrNullValue('', context),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).phoneNumber,
                hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                AppLocalizations.of(context).countrySelection,
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary, fontSize: 16),
              ),
            ),
            TextFormField(
              controller: _country,
              cursorColor: colorScheme.onBackground,
              style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).countrySelection,
                hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextButton(
                onPressed: () {
                  saveProfile(context, userModel);
                },
                child: Text(
                  AppLocalizations.of(context).saveAction,
                  style: textTheme.headlineLarge!.copyWith(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveProfile(BuildContext context, UserModel userModel) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Validators.instance.isLoading(context);

    String profilePhoto = userModel.profilePhoto;
    String banner = userModel.banner;

    final String firstName = _firstName.text;
    final String lastName = _lastName.text;
    final String bio = _bio.text;
    final String telephoneNumber = _telephoneNumber.text;
    final String country = _country.text;

    final Reference profilePhotoDirectory =
        FirebaseStorage.instance.ref().child('user_data/${userModel.id}/images/profile_photo/profile_photo');
    final Reference bannerDirectory =
        FirebaseStorage.instance.ref().child('user_data/${userModel.id}/images/banner_photo/banner_photo');

    if (_profilePhoto != null) {
      await profilePhotoDirectory.putFile(_profilePhoto!);
      final TaskSnapshot uploadTask = await profilePhotoDirectory.putFile(_profilePhoto!);
      profilePhoto = await uploadTask.ref.getDownloadURL();
    }

    if (_banner != null) {
      await bannerDirectory.putFile(_banner!);
      final TaskSnapshot uploadTask = await bannerDirectory.putFile(_banner!);
      banner = await uploadTask.ref.getDownloadURL();
    }

    try {
      final CollectionReference usersCollection = context.read<Repository>().getCollection;

      await usersCollection.doc(userModel.id).update({
        'name': '$firstName $lastName',
        'bio': bio,
        'telephoneNumber': telephoneNumber,
        'country': country,
        'profilePhoto': profilePhoto,
        'banner': banner,
      });

      Navigator.pushNamedAndRemoveUntil(
        context,
        'loginLoadingScreen',
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).oopsMessage),
        ),
      );
    }
  }
}
