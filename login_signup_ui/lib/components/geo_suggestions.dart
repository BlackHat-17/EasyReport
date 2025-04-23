import 'package:flutter/material.dart';
   import 'package:geolocator/geolocator.dart';
   import 'package:url_launcher/url_launcher.dart';
   import 'package:http/http.dart' as http;
   import 'dart:convert';
   import 'package:firebase_auth/firebase_auth.dart';
   import '../models/resource.dart';

   class GeoSuggestions extends StatefulWidget {
     const GeoSuggestions({super.key});

     @override
     _GeoSuggestionsState createState() => _GeoSuggestionsState();
   }

   class _GeoSuggestionsState extends State<GeoSuggestions> {
     Position? _location;
     List<Resource> _suggestions = [];
     String? _error;

     Future<void> _getLocation() async {
       bool serviceEnabled;
       LocationPermission permission;

       serviceEnabled = await Geolocator.isLocationServiceEnabled();
       if (!serviceEnabled) {
         setState(() {
           _error = 'Location services are disabled.';
         });
         return;
       }

       permission = await Geolocator.checkPermission();
       if (permission == LocationPermission.denied) {
         permission = await Geolocator.requestPermission();
         if (permission == LocationPermission.denied) {
           setState(() {
             _error = 'Location permissions are denied.';
           });
           return;
         }
       }

       try {
         final position = await Geolocator.getCurrentPosition();
         final user = FirebaseAuth.instance.currentUser;
         if (user == null) return;
         final token = await user.getIdToken();
         setState(() {
           _location = position;
           _error = null;
         });

         // Mock API call (replace with Firestore geospatial query in production)
         final response = await http.get(
           Uri.parse('http://localhost:8000/api/resources'),
           headers: {'Authorization': 'Bearer $token'},
         );
         if (response.statusCode == 200) {
           final List<dynamic> data = jsonDecode(response.body);
           setState(() {
             _suggestions = data.map((json) => Resource.fromJson(json)).toList();
           });
         }
       } catch (e) {
         setState(() {
           _error = 'Error fetching location or resources: $e';
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
               'Nearby Support',
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 16),
             ElevatedButton(
               onPressed: _getLocation,
               child: const Text('Find Nearby Resources'),
             ),
             const SizedBox(height: 16),
             if (_error != null)
               Text(
                 _error!,
                 style: const TextStyle(color: Colors.red),
               ),
             if (_location != null)
               Text('Location: Lat ${_location!.latitude}, Lng ${_location!.longitude}'),
             ListView.builder(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: _suggestions.length,
               itemBuilder: (context, index) {
                 final suggestion = _suggestions[index];
                 return ListTile(
                   title: Text(suggestion.name),
                   subtitle: Text(suggestion.type),
                   onTap: () async {
                     final url = Uri.parse(suggestion.url);
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