import 'package:terox_ai/data/model/choices_model.dart';
import 'package:terox_ai/data/model/usage_model.dart';

class DiagnosisModel {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<ChoicesModel> choicesModel;
  final UsageModel usageModel;

  DiagnosisModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choicesModel,
    required this.usageModel,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
    id: json['id'] ?? '',
    object: json['url'] ?? '',
    created: json['created'] ?? 0,
    model: json['model'] ?? '',
    choicesModel: List<ChoicesModel>.from(
      json['diagnosis']['choices'].map((x) => ChoicesModel.fromJson(x)) ?? [],
    ),
    usageModel: UsageModel.fromJson(json['diagnosis']['usage']),
  );
}
