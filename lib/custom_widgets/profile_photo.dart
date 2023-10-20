import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final String profilePhoto;
  final String name;
  final bool isOnline;
  final String profilePhotoType;

  const ProfilePhoto(
    this.profilePhoto,
    this.name,
    this.isOnline,
    this.profilePhotoType, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double coverHeight = 150;
    const double profileHeight = 144;
    late final double fontSize;
    late final double isOnlineWidth;
    late final double isOnlineHeight;
    late final double isOnlinex;
    late final double isOnliney;



    switch (profilePhotoType) {
      case 'contactProfilePhoto':
        fontSize = 20;
        isOnlineWidth = 10;
        isOnlineHeight = 10;
        isOnlinex = 0.4;
        isOnliney = 0.7;
        break;
      case 'myProfilePhoto':
        fontSize = 100;
        isOnlineWidth = 20;
        isOnlineHeight = 20;
        isOnlinex = 0.6;
        isOnliney = 0.8;
        break;
    }
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment(isOnlinex, isOnliney),
      children: [
        Container(
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
        ),
        Positioned(
          child: Container(
            width: isOnlineWidth,
            height: isOnlineHeight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOnline ? Colors.green : colorScheme.onBackground,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
