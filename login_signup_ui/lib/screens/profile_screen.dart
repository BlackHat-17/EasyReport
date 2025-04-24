// import 'package:flutter/material.dart';
// import '../components/profile_card.dart';
// import 'edit_profile_screen.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//       ),
//       body: ProfileCard(
//         userName: "Anjali Rathi",
//         userEmail: "anjali@example.com",
//         preferredLanguage: "English",
//         medicalLiteracyLevel: "Intermediate",
//         height: "5'5\"",
//         age: "25",
//         dob: "1998-05-01",
//         weight: "60 kg",
//         onEditProfile: () {
//           // Navigate to the Profile Edit screen
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const ProfileEditScreen()),
//           );
//         },
//       ),
//     );
//   }
// }