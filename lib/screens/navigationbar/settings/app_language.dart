import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';
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
    _selectedLanguage = gottenLocale != null ? gottenLocale : '';
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
        title: Text('', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              'Save',
              style: textTheme.headlineMedium,
            ),
            onPressed: () async {
              if (_selectedLanguage.length > 0) {
                await settings.setItem('appLocale', _selectedLanguage);
              }

              Navigator.pushNamedAndRemoveUntil(
                context,
                'loginLoadingScreen',
                (route) => false,
              );
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, i) {
            var language = languages[i];
            return RadioListTile(
              title: Text(language['name']),
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
