import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/widgets/elevatedbutton.dart';
import 'package:wolf_pack_test/controller/login_prov.dart';

class OTPScreen extends StatelessWidget {
  final String? verificationID;
  const OTPScreen({super.key, required this.verificationID});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Consumer<LoginProv>(
            builder: (context, value, child) {
              return Consumer<LoginProv>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: value.otpController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(hintText: 'OTO'),
                      ),
                      elevatedButton(
                          onPressed: () =>
                              value.verifyOTP(context, verificationID!),
                          hintText: 'verify')
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
