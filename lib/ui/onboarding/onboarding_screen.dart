import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:terox_ai/data/local/onboarding_data.dart';
import 'package:terox_ai/data/local/storage_repository.dart';
import 'package:terox_ai/ui/home/home_screen.dart';
import 'package:terox_ai/utils/extensions/navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged:
                    (index) => setState(() {
                      _currentPage = index;
                    }),
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(data['image']!, height: 350),
                        SizedBox(height: 32.h),
                        Text(
                          data['title']!,
                          style: TextStyle(
                            fontSize: 26.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        StorageRepository.putBool('isUserEntered', true);
                        context.pushAndRemoveUntil(HomeScreen());
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          _currentPage == onboardingData.length - 1
                              ? "Boshlash "
                              : "Davom etish ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
