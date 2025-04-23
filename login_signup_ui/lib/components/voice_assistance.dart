import 'package:flutter/material.dart';
   import 'package:speech_to_text/speech_to_text.dart';
   import 'package:flutter_tts/flutter_tts.dart';
   import 'package:http/http.dart' as http;
   import 'dart:convert';
   import 'package:firebase_auth/firebase_auth.dart';
   import '../models/translation.dart';

   class VoiceAssistant extends StatefulWidget {
     const VoiceAssistant({super.key});

     @override
     _VoiceAssistantState createState() => _VoiceAssistantState();
   }

   class _VoiceAssistantState extends State<VoiceAssistant> {
     final SpeechToText _speech = SpeechToText();
     final FlutterTts _tts = FlutterTts();
     String _transcript = '';
     String _response = '';

     Future<void> _startListening() async {
       bool available = await _speech.initialize();
       if (available) {
         _speech.listen(onResult: (result) async {
           setState(() {
             _transcript = result.recognizedWords;
           });
           if (result.finalResult && _transcript.isNotEmpty) {
             try {
               final user = FirebaseAuth.instance.currentUser;
               if (user == null) return;
               final token = await user.getIdToken();
               final response = await http.get(
                 Uri.parse('http://localhost:8000/api/translate/$_transcript'),
                 headers: {'Authorization': 'Bearer $token'},
               );
               if (response.statusCode == 200) {
                 final translation = Translation.fromJson(jsonDecode(response.body));
                 setState(() {
                   _response = translation.laypersonExplanation;
                 });
                 await _tts.speak(_response);
               } else {
                 setState(() {
                   _response = 'Sorry, I couldn’t find that term.';
                 });
                 await _tts.speak(_response);
               }
             } catch (e) {
               setState(() {
                 _response = 'Server error';
               });
               await _tts.speak(_response);
             }
           }
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
             const Text(
               'Voice Assistant',
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 16),
             ElevatedButton(
               onPressed: _startListening,
               child: const Text('Ask a Question'),
             ),
             const SizedBox(height: 16),
             if (_transcript.isNotEmpty)
               Text('You said: $_transcript'),
             if (_response.isNotEmpty)
               Text('Response: $_response'),
           ],
         ),
       );
     }
   }