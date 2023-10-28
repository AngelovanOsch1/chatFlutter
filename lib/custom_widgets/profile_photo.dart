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
    late final double coverHeight;
    late final double profileHeight;
    late final double fontSize;
    late final double isOnlineWidth;
    late final double isOnlineHeight;
    late final double isOnlinex;
    late final double isOnliney;

    switch (profilePhotoType) {
      case 'contactProfilePhoto':
        coverHeight = 50;
        profileHeight = 38;
        fontSize = 20;
        isOnlineWidth = 10;
        isOnlineHeight = 10;
        isOnlinex = 0.4;
        isOnliney = 0.7;
        break;
      case 'myProfilePhoto':
        coverHeight = 150;
        profileHeight = 144;
        fontSize = 100;
        isOnlineWidth = 20;
        isOnlineHeight = 20;
        isOnlinex = 0.6;
        isOnliney = 0.8;
        break;
      case 'chatScreen':
        coverHeight = 100;
        profileHeight = 54;
        fontSize = 100;
        isOnlineWidth = 15;
        isOnlineHeight = 15;
        isOnlinex = 0.5;
        isOnliney = 0.7;
        break;
    }
    return SizedBox(
      child: Stack(
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
            child: SizedBox(
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
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
