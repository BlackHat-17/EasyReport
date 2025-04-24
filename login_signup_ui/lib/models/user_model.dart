class User {
  final String id;
  final String name;
  final String email;
  final String preferredLanguage;
  final String medicalLiteracyLevel;
  final int translatedTerms;
  final int savedResources;
  final double profileCompletionPercentage;
  final List<String> connectedProviders;
  final String? profileImageUrl;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.preferredLanguage,
    required this.medicalLiteracyLevel,
    required this.translatedTerms,
    required this.savedResources,
    required this.profileCompletionPercentage,
    required this.connectedProviders,
    this.profileImageUrl,
  });
  
  // Factory constructor to create User from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      preferredLanguage: json['preferredLanguage'] ?? 'English',
      medicalLiteracyLevel: json['medicalLiteracyLevel'] ?? 'Intermediate',
      translatedTerms: json['translatedTerms'] ?? 0,
      savedResources: json['savedResources'] ?? 0,
      profileCompletionPercentage: json['profileCompletionPercentage'] ?? 0.0,
      connectedProviders: List<String>.from(json['connectedProviders'] ?? []),
      profileImageUrl: json['profileImageUrl'],
    );
  }
  
  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'preferredLanguage': preferredLanguage,
      'medicalLiteracyLevel': medicalLiteracyLevel,
      'translatedTerms': translatedTerms,
      'savedResources': savedResources,
      'profileCompletionPercentage': profileCompletionPercentage,
      'connectedProviders': connectedProviders,
      'profileImageUrl': profileImageUrl,
    };
  }
  
  // Create a dummy user for development/testing
  static User dummyUser() {
    return User(
      id: '123',
      name: 'Jane Doe',
      email: 'jane.doe@example.com',
      preferredLanguage: 'English',
      medicalLiteracyLevel: 'Intermediate',
      translatedTerms: 127,
      savedResources: 14,
      profileCompletionPercentage: 0.85,
      connectedProviders: ['General Hospital', 'Dr. Smith Clinic'],
      profileImageUrl: null, // Add URL here if you have one
    );
  }
}