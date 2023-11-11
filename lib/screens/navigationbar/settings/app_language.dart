import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:localstorage/localstorage.dart';

class AppLanguageScreen extends StatefulWidget {
  const AppLanguageScreen({super.key});

  @override
  State<AppLanguageScreen> createState() => _AppLanguageScreen();
}

class _AppLanguageScreen extends State<AppLanguageScreen> {
  String _selectedLanguage = '';
  final LocalStorage settings = LocalStorage('settings.json');

  @override
  void initState() {
    super.initState();
    String? gottenLocale = settings.getItem('appLocale');
    _selectedLanguage = gottenLocale ?? '';
  }

  List languages = [
    {
      'name': 'Nederlands',
      'value': 'nl',
    },
    {
      'name': 'English',
      'value': 'en',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          'App language',
          style: textTheme.headlineLarge!.copyWith(fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 30,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () async {
                  if (_selectedLanguage.isNotEmpty) {
                    await settings.setItem('appLocale', _selectedLanguage);
                  }
                  Phoenix.rebirth(context);
                },
                icon: const Icon(
                  Icons.save_outlined,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, i) {
            var language = languages[i];
            return RadioListTile(
              fillColor: MaterialStateProperty.resolveWith((states) => colorScheme.onBackground),
              title: Text(
                language['name'],
                style: textTheme.headlineMedium,
              ),
              value: language['value'],
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  debugPrint('value: ' + value.toString());
                  _selectedLanguage = value.toString();
                });
              },
            );
          }),
    );
  }
}
