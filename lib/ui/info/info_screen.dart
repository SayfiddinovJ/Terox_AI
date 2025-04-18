import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terox_ai/data/model/diagnosis_model.dart';
import 'package:terox_ai/utils/extensions/navigation.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    super.key,
    required this.diagnosisModel,
    required this.file,
  });

  final XFile file;
  final DiagnosisModel diagnosisModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: const Text(
          'Diagnostika ma\'lumotlari',
          overflow: TextOverflow.ellipsis,
        ),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.file(File(file.path), fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              Text(
                'Diagnostika: ${diagnosisModel.result}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text(
                    'Ortga qaytish',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
