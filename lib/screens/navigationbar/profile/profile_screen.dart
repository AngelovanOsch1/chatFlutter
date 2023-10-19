import 'package:chatapp/colors.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSceen extends StatefulWidget {
  const ProfileSceen({super.key});

  @override
  State<ProfileSceen> createState() => _ProfileSceenState();
}

class _ProfileSceenState extends State<ProfileSceen> {
  final double coverHeight = 150;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModelProvider>(context).userData;

    final ModalRoute<Object?>? parentRoute = ModalRoute.of(context);
    final bool hasLeadingIcon = parentRoute?.settings.name != '/profile';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        leading: hasLeadingIcon
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        title: Text(
          'My profile',
          style: textTheme.headlineLarge!.copyWith(fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'editProfileScreen');
                },
                icon: const Icon(
                  Icons.create,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          bannerAndProfilePhoto(userModel),
          nameAndBioInformation(userModel),
          profileInformation(userModel),
          profileButtons(),
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
    return Container(
      color: Colors.grey,
      child: userModel.banner.isEmpty
          ? Container(
              color: Colors.grey,
              width: double.infinity,
              height: coverHeight,
            )
          : Image.network(
              userModel.banner,
              width: double.infinity,
              height: coverHeight,
              fit: BoxFit.cover,
      ),
    );
  }

  Widget profilePhoto(UserModel userModel) {
    return ProfilePhoto(userModel.profilePhoto, userModel.name, 'myProfilePhoto');
  }

  Widget profileInformation(UserModel userModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 50),
      child: Wrap(
        runSpacing: 30,
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 140),
            child: Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: colorScheme.primary,
                  size: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'phone number',
                      style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        userModel.telephoneNumber,
                        style: textTheme.headlineSmall!.copyWith(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.email,
                color: colorScheme.primary,
                size: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email address',
                    style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      userModel.email,
                      style: textTheme.headlineSmall!.copyWith(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 140),
            child: Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.language_rounded,
                  color: colorScheme.primary,
                  size: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Country',
                      style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        userModel.country,
                        style: textTheme.headlineSmall!.copyWith(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nameAndBioInformation(UserModel userModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              userModel.name,
              style: textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 100, left: 100),
            child: Text(
              textAlign: TextAlign.center,
              userModel.bio,
              style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Divider(
              color: colorScheme.onBackground,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: null,
          ),
        ],
      ),
    );
  }

  Widget profileButtons() {
    return Center(
      child: Wrap(
        spacing: 15,
        children: [
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.only(left: 10, right: 10),
              ),
              backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'resetPasswordScreen');
            },
            child: Text(
              'Reset password',
              style: textTheme.headlineLarge!.copyWith(color: colorScheme.background, fontSize: 12),
            ),
          ),
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
              Navigator.pushNamed(context, 'changeEmailScreen');
            },
            child: Text(
              'Change email',
              style: textTheme.headlineLarge!.copyWith(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
