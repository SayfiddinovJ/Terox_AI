import 'package:terox_ai/data/model/diagnosis_model.dart';
import 'package:terox_ai/data/status.dart';

class ImageState {
  final String statusText;
  final DiagnosisModel diagnosisModel;
  final FormStatus status;

  const ImageState({
    required this.statusText,
    required this.diagnosisModel,
    required this.status,
  });

  ImageState copyWith({
    String? statusText,
    DiagnosisModel? diagnosisModel,
    FormStatus? status,
  }) {
    return ImageState(
      statusText: statusText ?? this.statusText,
      diagnosisModel: diagnosisModel ?? this.diagnosisModel,
      status: status ?? this.status,
    );
  }
}
