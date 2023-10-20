import 'package:chatapp/colors.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  UserModel? selectedUserModel;

  // ignore: use_key_in_widget_constructors
  ProfileScreen({Key? key, this.selectedUserModel});

  final double coverHeight = 150;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    
    // ignore: prefer_conditional_assignment
    if (selectedUserModel == null) {
      selectedUserModel = Provider.of<UserModelProvider>(context).userData;
    } 

    List<String> name = Validators.instance.splitFirstNameAndLastName(selectedUserModel!.name);

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
          selectedUserModel?.id == context.read<Repository>().getAuth.currentUser?.uid
              ? AppLocalizations.of(context).myProfile
              : "${name[0]}'s" + AppLocalizations.of(context).profile,
          style: textTheme.headlineLarge!.copyWith(fontSize: 25),
        ),
        actions: [
          selectedUserModel?.id == context.read<Repository>().getAuth.currentUser?.uid
              ? 
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
                )
              : Container()
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          bannerAndProfilePhoto(selectedUserModel!),
          nameAndBioInformation(selectedUserModel!),
          profileInformation(selectedUserModel!, context),
          profileButtons(context),
        ],
      ),
    );
  }

  Widget bannerAndProfilePhoto(UserModel selectedUserModel) {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: banner(selectedUserModel),
        ),
        Positioned(
          top: top,
          child: profilePhoto(selectedUserModel),
        ),
      ],
    );
  }

  Widget banner(UserModel selectedUserModel) {
    return Container(
      color: Colors.grey,
      child: selectedUserModel.banner.isEmpty
          ? Container(
              color: Colors.grey,
              width: double.infinity,
              height: coverHeight,
            )
          : Image.network(
              selectedUserModel.banner,
              width: double.infinity,
              height: coverHeight,
              fit: BoxFit.cover,
      ),
    );
  }

  Widget profilePhoto(UserModel selectedUserModel) {
    return ProfilePhoto(selectedUserModel.profilePhoto, selectedUserModel.name, selectedUserModel.isOnline, 'myProfilePhoto');
  }

  Widget profileInformation(UserModel selectedUserModel, BuildContext context) {
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
                      AppLocalizations.of(context).phoneNumber,
                      style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        selectedUserModel.telephoneNumber,
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
                    AppLocalizations.of(context).emailAddress,
                    style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      selectedUserModel.email,
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
                      AppLocalizations.of(context).countrySelection,
                      style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        selectedUserModel.country,
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

  Widget profileButtons(BuildContext context) {
    return selectedUserModel?.id == context.read<Repository>().getAuth.currentUser?.uid
        ? Center(
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
                    AppLocalizations.of(context).resetPasswordAction,
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
                    AppLocalizations.of(context).changeEmailAction,
              style: textTheme.headlineLarge!.copyWith(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
          )
        : Container();
  }
}
