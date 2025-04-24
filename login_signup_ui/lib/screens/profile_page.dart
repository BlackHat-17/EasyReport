import 'package:flutter/material.dart';
import '../components/profile_card.dart';
import '../models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key}); // ✅ Updated to use super parameter

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = User.dummyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(
              userName: currentUser.name,
              userEmail: currentUser.email,
              preferredLanguage: currentUser.preferredLanguage,
              medicalLiteracyLevel: currentUser.medicalLiteracyLevel,
              profileImageUrl: currentUser.profileImageUrl,
              translatedTerms: currentUser.translatedTerms,
              savedResources: currentUser.savedResources,
              completionPercentage: currentUser.profileCompletionPercentage,
              onEditProfile: _showEditProfileDialog,
              onViewHistory: _navigateToHistory,
            ),
            _buildSettingsSection(),
            _buildPrivacySection(),
            _buildSupportSection(),
          ],
          
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
            const Divider(),
            _buildSettingTile(
              'Language Preferences',
              Icons.language,
              _showLanguageDialog,
            ),
            const Divider(height: 1),
            _buildSettingTile(
              'Medical Literacy Level',
              Icons.menu_book,
              _showLiteracyDialog,
            ),
            const Divider(height: 1),
            _buildSettingTile(
              'Notification Settings',
              Icons.notifications,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Privacy & Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
            const Divider(),
            _buildSettingTile(
              'Data Sharing Options',
              Icons.security,
              () {},
            ),
            const Divider(height: 1),
            _buildSettingTile(
              'Connect Healthcare Providers',
              Icons.link,
              () {},
            ),
            const Divider(height: 1),
            _buildSettingTile(
              'Export My Medical Data',
              Icons.download,
              () {},
            ),
            TextButton(
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
            child: const Text('Epa report'),
          ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
            const Divider(),
            _buildSettingTile(
              'How to Use This App',
              Icons.help_outline,
              () {},
            ),
            const Divider(height: 1),
            _buildSettingTile(
              'Contact Support',
              Icons.support_agent,
              () {},
            ),
            const Divider(height: 1),
            _buildSettingTile(
              'About',
              Icons.info_outline,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Text('This feature will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _navigateToHistory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Translation history will be shown here')),
    );
  }

  void _showLanguageDialog() {
    final languages = ['English', 'Spanish', 'French', 'German', 'Chinese'];
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Language'),
        children: languages
            .map((lang) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(lang),
                ))
            .toList(),
      ),
    );
  }

  void _showLiteracyDialog() {
    final levels = ['Beginner', 'Intermediate', 'Advanced', 'Medical Professional'];
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Medical Literacy Level'),
        children: levels
            .map((level) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(level),
                ))
            .toList(),
      ),
    );
  }
}