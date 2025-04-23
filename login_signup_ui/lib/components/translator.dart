import 'package:flutter/material.dart';
   import 'package:http/http.dart' as http;
   import 'dart:convert';
   import 'package:firebase_auth/firebase_auth.dart';
   import '../models/translation.dart';

   class Translator extends StatefulWidget {
     const Translator({super.key});

     @override
     _TranslatorState createState() => _TranslatorState();
   }

   class _TranslatorState extends State<Translator> {
     final TextEditingController _controller = TextEditingController();
     Translation? _result;
     String? _error;

     Future<void> _translate() async {
       final code = _controller.text.trim();
       if (code.isEmpty) return;

       try {
         final user = FirebaseAuth.instance.currentUser;
         if (user == null) {
           setState(() {
             _error = 'Please sign in';
             _result = null;
           });
           return;
         }
         final token = await user.getIdToken();
         final response = await http.get(
           Uri.parse('http://localhost:8000/api/translate/$code'),
           headers: {'Authorization': 'Bearer $token'},
         );
         if (response.statusCode == 200) {
           setState(() {
             _result = Translation.fromJson(jsonDecode(response.body));
             _error = null;
           });
         } else {
           setState(() {
             _error = jsonDecode(response.body)['detail'];
             _result = null;
           });
         }
       } catch (e) {
         setState(() {
           _error = 'Server error';
           _result = null;
         });
       }
     }

     @override
     Widget build(BuildContext context) {
       return Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             TextField(
               controller: _controller,
               decoration: const InputDecoration(
                 labelText: 'Enter ICD code or term',
                 border: OutlineInputBorder(),
               ),
             ),
             const SizedBox(height: 16),
             ElevatedButton(
               onPressed: _translate,
               child: const Text('Translate'),
             ),
             const SizedBox(height: 16),
             if (_error != null)
               Text(
                 _error!,
                 style: const TextStyle(color: Colors.red),
               ),
             if (_result != null)
               Card(
                 child: Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         _result!.medicalTerm,
                         style: const TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       const SizedBox(height: 8),
                       Text(_result!.laypersonExplanation),
                       const SizedBox(height: 8),
                       Text(
                         'Source: ${_result!.source} (Trust Score: ${_result!.trustScore})',
                         style: const TextStyle(color: Colors.grey),
                       ),
                     ],
                   ),
                 ),
               ),
           ],
         ),
       );
     }
   }