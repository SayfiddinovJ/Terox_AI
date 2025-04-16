import 'package:terox_ai/data/model/message_model.dart';

class ChoicesModel {
  final int index;
  final MessageModel message;
  final String finishReason;

  ChoicesModel({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  factory ChoicesModel.fromJson(Map<String, dynamic> json) {
    return ChoicesModel(
      index: json['index'] ?? '',
      message: MessageModel.fromJson(json['message']),
      finishReason: json['finishReason'] ?? '',
    );
  }
}
