import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:terox_ai/bloc/image_bloc.dart';
import 'package:terox_ai/repository/image_repo.dart';
import 'package:terox_ai/ui/splash/splash_screen.dart';

import 'data/local/storage_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => ImageRepo())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => ImageBloc(imageRepo: context.read<ImageRepo>()),
          ),
        ],
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Color(0xFF6574CF)),
          home: SplashScreen(),
        );
      },
    );
  }
}
