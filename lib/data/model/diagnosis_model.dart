class DiagnosisModel {
  final String result;

  DiagnosisModel({required this.result});

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) =>
      DiagnosisModel(result: json['diagnosis']['message'] ?? '');
}
