import 'package:image_picker/image_picker.dart';
import 'package:terox_ai/data/universal_data.dart';
import 'package:terox_ai/service/image_uploader.dart';

class ImageRepo {
  Future<UniversalData> getImage(XFile file) => imageUploader(file);
}
