import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final String profilePhoto;
  final String name;
  final String profilePhotoType;

  const ProfilePhoto(
    this.profilePhoto,
    this.name,
    this.profilePhotoType, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double coverHeight = 150;
    double profileHeight = 144;
    double fontSize = 0;

    switch (profilePhotoType) {
      case 'contactProfilePhoto':
        fontSize = 20;
        break;
      case 'myProfilePhoto':
        fontSize = 100;
        break;
    }
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colorScheme.background,
          width: 10,
        ),
      ),
      child: CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        child: profilePhoto.isEmpty
            ? Text(
                name[0],
                style: textTheme.headlineLarge!.copyWith(fontSize: fontSize),
              )
            : ClipOval(
                child: Image.network(
                  profilePhoto,
                  width: double.infinity,
                  height: coverHeight,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
