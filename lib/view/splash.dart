import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/controller/splash_prov.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SplashProv>(context, listen: false).navigateTo(context);
    });
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
