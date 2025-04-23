class Translation {
  final String code;
  final String medicalTerm;
  final String laypersonExplanation;
  final String source;
  final double trustScore;

  Translation({
    required this.code,
    required this.medicalTerm,
    required this.laypersonExplanation,
    required this.source,
    required this.trustScore,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      code: json['code'],
      medicalTerm: json['medical_term'],
      laypersonExplanation: json['layperson_explanation'],
      source: json['source'],
      trustScore: (json['trust_score'] as num).toDouble(),
    );
  }
}
