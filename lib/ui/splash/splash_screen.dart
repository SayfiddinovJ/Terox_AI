import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:terox_ai/ui/app/app.dart';
import 'package:terox_ai/utils/app_images/app_images.dart';
import 'package:terox_ai/utils/extensions/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkInternetAndNavigate();
  }

  Future<void> checkInternetAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    var connectivityResult = await Connectivity().checkConnectivity();
    bool isOnline =
        connectivityResult.first == ConnectivityResult.wifi ||
        connectivityResult.first == ConnectivityResult.mobile;

    if (mounted) {
      if (isOnline) {
        context.pushAndRemoveUntil(App());
      } else {
        showNoInternetDialog();
      }
    }
  }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4),
          iconColor: Colors.red,
          title: Text("Internet yo‘q!"),
          content: Text("Iltimos, internet yoki Wi-Fi-ga ulaning."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                checkInternetAndNavigate();
              },
              child: Text(
                "Qayta urinish",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.logo, height: 250.h, width: 250.w),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFFFFFFF),
    );
  }
}
