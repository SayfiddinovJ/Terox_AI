import 'package:flutter/material.dart';
import 'package:terox_ai/data/local/storage_repository.dart';
import 'package:terox_ai/ui/home/home_screen.dart';
import 'package:terox_ai/ui/onboarding/onboarding_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    bool isUserEntered = StorageRepository.getBool('isUserEntered');
    return isUserEntered ? const HomeScreen() : const OnboardingScreen();
  }
}
