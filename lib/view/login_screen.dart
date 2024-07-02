import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/constants/size/size.dart';
import 'package:wolf_pack_test/constants/styles/textform_styles.dart';
import 'package:wolf_pack_test/constants/widgets/elevatedbutton.dart';
import 'package:wolf_pack_test/constants/widgets/textformfield_.dart';
import 'package:wolf_pack_test/controller/login_prov.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Consumer<LoginProv>(
            builder: (context, value, child) {
              return Form(
                key: value.loginFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(text: 'Login ', style: kMainTitleStyle),
                          TextSpan(text: ' or ', style: kHintTitleStyle),
                          TextSpan(text: ' Signup', style: kMainTitleStyle)
                        ]),
                      ),
                      kHeight15,
                      customText(text: 'Mobile Number'),
                      kHeigh5,
                      textFormField(
                        controller: value.mobileController,
                        keyboardType: TextInputType.phone,
                        validator: (val) => value.validateMobile(val!),
                      ),
                      kHeight25,
                      elevatedButton(
                          onPressed: () {
                            value.phoneSignIn(context);
                          },
                          hintText: 'Login'),
                      kHeight25,
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Text(' Or signup with '),
                          Expanded(child: Divider()),
                        ],
                      ),
                      kHeight25,
                      kHeight25,
                      ElevatedButton(
                        onPressed: () {
                          value.googleSignIn(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(color: kBlack),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://image.similarpng.com/thumbnail/2020/12/Flat-design-Google-logo-design-Vector-PNG.png',
                                height: 24.0,
                              ),
                              kWidth10,
                              const Text(
                                'Sign in with Google',
                                style: kHintTitleStyle,
                              ),
                            ]),
                      )
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
