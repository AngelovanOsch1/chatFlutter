import 'package:chatapp/colors.dart';
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
    final top = coverHeight - profileHeight / 2;
    final userData = Provider.of<UserDataProvider>(context).userData;

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
                onPressed: () {},
                  icon: const Icon(
                    Icons.create,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.grey,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/chatappforschool.appspot.com/o/anime-art-style-environment-background-image_492154-389.avif?alt=media&token=5490ee16-a28c-47a4-9e1b-32e5bedb13b3',
                width: double.infinity,
                height: coverHeight,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: top,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 5.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: profileHeight / 2,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: NetworkImage(userData.profilePhoto),
                ),
              ),
            )
          ],
        )
    );
  }
}
