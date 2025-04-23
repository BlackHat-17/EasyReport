import 'package:flutter/material.dart';
   import 'package:http/http.dart' as http;
   import 'dart:convert';
   import 'package:url_launcher/url_launcher.dart';
   import 'package:firebase_auth/firebase_auth.dart';
   import '../models/resource.dart';

   class Resources extends StatefulWidget {
     const Resources({super.key});

     @override
     _ResourcesState createState() => _ResourcesState();
   }

   class _ResourcesState extends State<Resources> {
     List<Resource> _resources = [];

     @override
     void initState() {
       super.initState();
       _fetchResources();
     }

     Future<void> _fetchResources() async {
       try {
         final user = FirebaseAuth.instance.currentUser;
         if (user == null) return;
         final token = await user.getIdToken();
         final response = await http.get(
           Uri.parse('http://localhost:8000/api/resources'),
           headers: {'Authorization': 'Bearer $token'},
         );
         if (response.statusCode == 200) {
           final List<dynamic> data = jsonDecode(response.body);
           setState(() {
             _resources = data.map((json) => Resource.fromJson(json)).toList();
           });
         }
       } catch (e) {
         print('Error fetching resources: $e');
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
               'Support Resources',
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 16),
             ListView.builder(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: _resources.length,
               itemBuilder: (context, index) {
                 final resource = _resources[index];
                 return ListTile(
                   title: Text(resource.name),
                   subtitle: Text('${resource.type}${resource.region != null ? ' - ${resource.region}' : ''}'),
                   onTap: () async {
                     final url = Uri.parse(resource.url);
                     if (await canLaunchUrl(url)) {
                       await launchUrl(url);
                     }
                   },
                 );
               },
             ),
           ],
         ),
       );
     }
   }