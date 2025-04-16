import 'package:image_picker/image_picker.dart';

abstract class ImageEvent {}

class GetImageEvent extends ImageEvent {
  final XFile file;

  GetImageEvent({required this.file});
}

class PureImageEvent extends ImageEvent {}
