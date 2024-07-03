import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/controller/chat_prov.dart';
import 'package:wolf_pack_test/controller/home_prov.dart';
import 'package:wolf_pack_test/controller/login_prov.dart';
import 'package:wolf_pack_test/controller/profile_prov.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/controller/splash_prov.dart';
import 'package:wolf_pack_test/controller/welcome_prov.dart';
import 'package:wolf_pack_test/view/chat_screen.dart';
import 'package:wolf_pack_test/view/connection_details.dart';
import 'package:wolf_pack_test/view/home_screen.dart';
import 'package:wolf_pack_test/view/login_screen.dart';
import 'package:wolf_pack_test/view/otp_screen.dart';
import 'package:wolf_pack_test/view/profile_screen.dart';
import 'package:wolf_pack_test/view/splash.dart';
import 'package:wolf_pack_test/view/welcome_screen.dart';
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
        ChangeNotifierProvider(create: (_) => WelcomeProv()),
        ChangeNotifierProvider(create: (_) => HomeProv()),
        ChangeNotifierProvider(create: (_) => ProfileProv()),
        ChangeNotifierProvider(create: (_) => ChatProv()),
      ],
      child: MaterialApp(
        color: kprimary,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/login_screen": (context) => const LoginScreen(),
          "/otp_screen": (context) => const OTPScreen(),
          "/welcome_screen": (context) => const WelcomeScreen(),
          "/home_screen": (context) => const HomeScreen(),
          "/profile_screen": (context) => const ProfileScreen(),
          "/chat_screen": (context) => const ChatPage(),
          "/connection_profile": (context) => ConnectionProfile(),
        },
      ),
    );
  }
}
