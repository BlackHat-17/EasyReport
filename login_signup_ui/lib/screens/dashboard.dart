import 'package:flutter/material.dart';
   import 'package:firebase_auth/firebase_auth.dart';
   import '../components/translator.dart';
   import '../components/resource.dart';
   import '../components/geo_suggestions.dart';
  //  import '../components/voice_assistance.dart';
   import '../components/language_selector.dart';

   class Dashboard extends StatefulWidget {
     const Dashboard({super.key});

     @override
     _DashboardState createState() => _DashboardState();
   }

   class _DashboardState extends State<Dashboard> {
     String _summary = '';
     String _selectedLanguage = 'en';

     void _generateSummary() {
       setState(() {
         _summary = 'Your recent records show a diagnosis of hypertension. Recommended actions include lifestyle changes and medication.';
       });
     }

     void _onLanguageChanged(String language) {
       setState(() {
         _selectedLanguage = language;
       });
       print('Language changed to: $language');
     }

     Future<void> _signIn() async {
       try {
         await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: "test@example.com",
           password: "password123",
         );
       } catch (e) {
         print('Sign-in error: $e');
       }
     }

     Future<void> _signOut() async {
       await FirebaseAuth.instance.signOut();
     }

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           title: const Text('Smart ePA Translator'),
           actions: [
             IconButton(
               icon: const Icon(Icons.login),
               onPressed: _signIn,
             ),
             IconButton(
               icon: const Icon(Icons.logout),
               onPressed: _signOut,
             ),
           ],
         ),
         body: SingleChildScrollView(
           child: Column(
             children: [
               const Translator(),
               ElevatedButton(
                 onPressed: _generateSummary,
                 child: const Text('Generate Summary'),
               ),
               if (_summary.isNotEmpty)
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Text(_summary),
                 ),
               const Resources(),
               const GeoSuggestions(),
              //  const VoiceAssistant(),
               LanguageSelector(onLanguageChanged: _onLanguageChanged),
             ],
           ),
         ),
       );
     }
   }