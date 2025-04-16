import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terox_ai/bloc/image_bloc.dart';
import 'package:terox_ai/bloc/product_event.dart';
import 'package:terox_ai/bloc/product_state.dart';
import 'package:terox_ai/data/status.dart';
import 'package:terox_ai/data/universal_data.dart';
import 'package:terox_ai/service/image_uploader.dart';
import 'package:terox_ai/ui/info/info_screen.dart';
import 'package:terox_ai/utils/dialogs/loading.dart';
import 'package:terox_ai/utils/dialogs/show_dialog.dart';
import 'package:terox_ai/utils/extensions/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ImagePicker picker = ImagePicker();
  File file = File('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if (state.status == FormStatus.success) {
              context.push(
                InfoScreen(diagnosisModel: state.diagnosisModel, file: file),
              );
            } else if (state.status == FormStatus.failure) {
              showMessage(
                message: 'Ma\'lumot olishda xatoli!',
                context: context,
              );
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: InkWell(
                  onTap: () {
                    showBottomSheetDialog(context);
                  },
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: MediaQuery.of(context).size.width - 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.grey[400],
                    ),
                    child:
                        file.path.isEmpty
                            ? const Center(
                              child: Text(
                                'Rasmga oling yoki galereyadan tanlang',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                            : Image.file(file),
                  ),
                ),
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
      UniversalData data = await imageUploader(xFile);
      if (context.mounted) {
        context.read<ImageBloc>().add(GetImageEvent(file: xFile));
      }
      print('Data: ${data.data}');
      print('Data: ${data.error}');
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
      if (context.mounted) {
        context.read<ImageBloc>().add(GetImageEvent(file: xFile));
      }
      // UniversalData data = await imageUploader(xFile);
      if (context.mounted) {
        hideLoading(context: context);
        context.pop();
      }
    }
  }
}
