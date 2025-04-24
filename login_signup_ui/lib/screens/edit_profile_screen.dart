// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Firestore

// class ProfileEditScreen extends StatefulWidget {
//   const ProfileEditScreen({Key? key}) : super(key: key);

//   @override
//   _ProfileEditScreenState createState() => _ProfileEditScreenState();
// }

// class _ProfileEditScreenState extends State<ProfileEditScreen> {
//   // Controllers for text input fields
//   final _heightController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _dobController = TextEditingController();
//   final _weightController = TextEditingController();

//   // Form key to manage form validation
//   final _formKey = GlobalKey<FormState>();

//   // Function to save profile data to Firestore
//   Future<void> _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       // Get the input data from controllers
//       String height = _heightController.text;
//       String age = _ageController.text;
//       String dob = _dobController.text;
//       String weight = _weightController.text;

//       // Save the data to Firestore (assuming user ID is already available)
//       try {
//         await FirebaseFirestore.instance.collection('users').doc('userId').set({
//           'height': height,
//           'age': age,
//           'dob': dob,
//           'weight': weight,
//         });
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Profile saved to Firestore')),
//         );
        
//         // After saving, navigate back to the profile screen
//         Navigator.pop(context);
//       } catch (e) {
//         // Handle any errors
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error saving profile: $e')),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _heightController.dispose();
//     _ageController.dispose();
//     _dobController.dispose();
//     _weightController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Profile"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _saveProfile,  // Save profile when clicked
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // Height Input
//               TextFormField(
//                 controller: _heightController,
//                 decoration: const InputDecoration(
//                   labelText: "Height",
//                   hintText: "Enter your height",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your height';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Age Input
//               TextFormField(
//                 controller: _ageController,
//                 decoration: const InputDecoration(
//                   labelText: "Age",
//                   hintText: "Enter your age",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your age';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Date of Birth Input
//               TextFormField(
//                 controller: _dobController,
//                 decoration: const InputDecoration(
//                   labelText: "Date of Birth",
//                   hintText: "Enter your date of birth",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.datetime,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your date of birth';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Weight Input
//               TextFormField(
//                 controller: _weightController,
//                 decoration: const InputDecoration(
//                   labelText: "Weight",
//                   hintText: "Enter your weight",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your weight';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Save Button
//               ElevatedButton(
//                 onPressed: _saveProfile,
//                 child: const Text("Save Profile"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }