import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/controller/splash_prov.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SplashProv>(context, listen: false).navigateTo(context);
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: kprimary,
        body: Center(
            child: Lottie.asset('assets/animations/splash_animation.json')),
      ),
    );
  }
}
