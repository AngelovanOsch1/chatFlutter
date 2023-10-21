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
              if (_selectedLanguage.isNotEmpty) {
                await settings.setItem('appLocale', _selectedLanguage);
              }
              Phoenix.rebirth(context);
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
