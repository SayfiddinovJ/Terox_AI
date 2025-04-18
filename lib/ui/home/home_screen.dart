import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terox_ai/bloc/image_bloc.dart';
import 'package:terox_ai/bloc/product_event.dart';
import 'package:terox_ai/bloc/product_state.dart';
import 'package:terox_ai/data/status.dart';
import 'package:terox_ai/ui/info/info_screen.dart';
import 'package:terox_ai/utils/dialogs/loading.dart';
import 'package:terox_ai/utils/extensions/navigation.dart';
import 'package:terox_ai/utils/snack_bar/snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ImagePicker picker = ImagePicker();
  String image = '';
  XFile file = XFile('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if (state.status == FormStatus.success) {
              hideLoading(context: context);
              Utils.showCustomSnackBar(
                context: context,
                message: 'Diagnos ma\'lumotlari muvaffaqiyatli yuklandi',
                backgroundColor: Colors.green,
                icon: Icons.done,
              );
              context.push(
                InfoScreen(diagnosisModel: state.diagnosisModel, file: file),
              );
            } else if (state.status == FormStatus.failure) {
              hideLoading(context: context);
              Utils.showCustomSnackBar(
                context: context,
                message: 'Xatolik, ma\'lumotlarni olishda xatolik',
                backgroundColor: Colors.red,
                icon: Icons.error_outline,
              );
            } else if (state.status == FormStatus.loading) {
              showLoading(context: context);
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: image.isNotEmpty,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: MediaQuery.of(context).size.width - 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.grey[400],
                        ),
                        child: Image.file(File(image), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      showBottomSheetDialog(context);
                    },
                    child: Text('Rasmni yuklash'),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: () {
                      if (image.isNotEmpty) {
                        context.read<ImageBloc>().add(
                          GetImageEvent(file: file),
                        );
                      } else {
                        Utils.showCustomSnackBar(
                          context: context,
                          message: 'Xatolik, rasm yuklanmadi',
                          backgroundColor: Colors.red,
                          icon: Icons.error_outline,
                        );
                      }
                    },
                    child: Text('Rasmni tekshirish'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _getFromCamera(context);
                  },
                  leading: const Icon(Icons.camera_alt, color: Colors.black),
                  title: const Text(
                    "Kameradan tanlash",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _getFromGallery(context);
                  },
                  leading: const Icon(Icons.photo, color: Colors.black),
                  title: const Text(
                    "Galereyadan tanlash",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (context.mounted && xFile != null) {
      showLoading(context: context);
      setState(() {
        file = xFile;
        image = xFile.path;
      });
      if (context.mounted) {
        hideLoading(context: context);
        context.pop();
      }
    }
  }

  Future<void> _getFromGallery(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (context.mounted && xFile != null) {
      showLoading(context: context);
      setState(() {
        file = xFile;
        image = xFile.path;
      });
      if (context.mounted) {
        hideLoading(context: context);
        context.pop();
      }
    }
  }
}
