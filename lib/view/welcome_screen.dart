import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/size/size.dart';
import 'package:wolf_pack_test/constants/styles/textform_styles.dart';
import 'package:wolf_pack_test/constants/widgets/elevatedbutton.dart';
import 'package:wolf_pack_test/constants/widgets/textformfield_.dart';
import 'package:wolf_pack_test/controller/welcome_prov.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/check.png',
                            height: 30,
                          ),
                        ),
                        kWidth10,
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Welcome to Wolftalks',
                                style: kMainTitleStyle),
                            Text('Your account has been created'),
                          ],
                        ),
                      ],
                    ),
                  ))),
          Consumer<WelcomeProv>(
            builder: (context, value, child) {
              return Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(text: 'What should we call you?'),
                      kHeigh5,
                      textFormField(
                          controller: value.nameController,
                          hintText: 'Type your name (Optional)'),
                      kHeight25,
                      elevatedButton(
                        onPressed: () {
                          Provider.of<WelcomeProv>(context, listen: false)
                              .updateName(context);
                        },
                        hintText: 'CONTINUE',
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
