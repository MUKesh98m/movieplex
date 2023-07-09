import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:webview/apppreference.dart';
import 'package:webview/controller/home_controller.dart';
import 'package:webview/splash_screen.dart';

void main() async {
  runApp(const MyApp());
  await AppPreference.init();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppPreference.set(
      'buildNumber', '${packageInfo.version} (${packageInfo.buildNumber})');
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeController()),
/*          ChangeNotifierProvider.value(value: CompilerController()),*/
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(
            iconTheme:
                IconThemeData(color: Colors.white), // Set the icon color here
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
