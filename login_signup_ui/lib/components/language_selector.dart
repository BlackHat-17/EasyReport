import 'package:flutter/material.dart';

   class LanguageSelector extends StatefulWidget {
     final Function(String) onLanguageChanged;

     const LanguageSelector({super.key, required this.onLanguageChanged});

     @override
     _LanguageSelectorState createState() => _LanguageSelectorState();
   }

   class _LanguageSelectorState extends State<LanguageSelector> {
     String _selectedLanguage = 'en';

     final Map<String, String> _languages = {
       'en': 'English',
       'es': 'Spanish',
       'fr': 'French',
     };

     @override
     Widget build(BuildContext context) {
       return Padding(
         padding: const EdgeInsets.all(16.0),
         child: DropdownButton<String>(
           value: _selectedLanguage,
           onChanged: (value) {
             setState(() {
               _selectedLanguage = value!;
             });
             widget.onLanguageChanged(value!);
           },
           items: _languages.entries
               .map((entry) => DropdownMenuItem(
                     value: entry.key,
                     child: Text(entry.value),
                   ))
               .toList(),
         ),
       );
     }
   }