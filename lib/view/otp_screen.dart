import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/size/size.dart';
import 'package:wolf_pack_test/constants/styles/textform_styles.dart';
import 'package:wolf_pack_test/constants/widgets/elevatedbutton.dart';
import 'package:wolf_pack_test/controller/login_prov.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final verificationID =
        ModalRoute.of(context)?.settings.arguments as String?;

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
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Phone Number verification',
                                    style:
                                        kMainTitleStyle.copyWith(fontSize: 26)),
                                kHeight10,
                                Text(
                                    'Enter the code sent to ${value.mobileController.text}',
                                    style:
                                        kHintTitleStyle.copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              PinCodeTextField(
                                controller: value.otpController,
                                appContext: context,
                                length: 6,
                                obscureText: true,
                                obscuringCharacter: '*',
                                blinkWhenObscuring: true,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeFillColor: Colors.white,
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  value.otpController.text = val;
                                },
                              ),
                              kHeight20,
                              elevatedButton(
                                  onPressed: () =>
                                      value.verifyOTP(context, verificationID!),
                                  hintText: 'VERIFY')
                            ],
                          ),
                        ),
                      ),
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
