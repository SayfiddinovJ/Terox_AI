import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:terox_ai/data/universal_data.dart';

Future<UniversalData> imageUploader(XFile file) async {
  Dio dio = Dio();

  String fileName = file.path.split('/').last;

  FormData formData = FormData.fromMap({
    "image": await MultipartFile.fromFile(
      file.path,
      filename: fileName,
      contentType: MediaType("image", "jpeg"),
    ),
  });

  try {
    Response response = await dio.post(
      'https://redoxai-production.up.railway.app/api/v1/diagnose/',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.statusCode == 200) {
      debugPrint("✅ Javob: ${response.data}");
      return UniversalData(data: response.data);
    } else {
      debugPrint("❌ Xatolik status: ${response.statusCode}");
      return UniversalData(error: "Xatolik");
    }
  } catch (e) {
    debugPrint("⚠️ Serverga ulanishda xatolik: $e");
    return UniversalData(error: e.toString());
  }
}
