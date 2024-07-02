import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/widgets/elevatedbutton.dart';
import 'package:wolf_pack_test/controller/login_prov.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          elevatedButton(
            onPressed: () =>
                Provider.of<LoginProv>(context, listen: false).signOut(context),
            hintText: 'Login',
          )
        ],
      ),
    );
  }
}
