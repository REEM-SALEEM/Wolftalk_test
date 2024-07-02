import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/controller/login_prov.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/controller/splash_prov.dart';
import 'package:wolf_pack_test/view/splash.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SharedPrefsProv()),
        ChangeNotifierProvider(create: (_) => SplashProv()),
        ChangeNotifierProvider(create: (_) => LoginProv()),

        // ChangeNotifierProvider(create: (_) => InfoProv()),
        // ChangeNotifierProvider(create: (_) => InfoProv()),
      ],
      child: const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
