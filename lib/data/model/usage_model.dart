class UsageModel {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  UsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory UsageModel.fromJson(Map<String, dynamic> json) => UsageModel(
    promptTokens: json['prompt_tokens'] ?? '',
    completionTokens: json['completion_tokens'] ?? '',
    totalTokens: json['total_tokens'] ?? '',
  );
}
