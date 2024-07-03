import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/constants/size/size.dart';
import 'package:wolf_pack_test/constants/styles/textform_styles.dart';
import 'package:wolf_pack_test/constants/widgets/elevatedbutton.dart';

class ConnectionProfile extends StatelessWidget {
  // dynamic userData;
  // ConnectionProfile({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final args = arguments['userData'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: args['profilePic'].isNotEmpty
                    // userData['profilePic'].isNotEmpty
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(args['profilePic']),
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 150,
                        color: Colors.grey[700],
                      ),
              ),
              kHeight10,
              Text(
                args['fullName'].toString(),
                style: kMainTitleStyle,
              ),
              Text(args['email'].isNotEmpty ? args['email'] : args['mobile']),
              kHeight35,
              Container(
                decoration: const BoxDecoration(
                    color: kGrey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 80,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(args['bio'].isNotEmpty ? args['bio'] : '---'),
                ),
              ),
              kHeight35,
              elevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/chat_screen', arguments: {
                      'receiverEmail': args["fullName"],
                      'receiverID': args["uid"],
                    });
                  },
                  hintText: 'INITIATE A CONVERSATION'),
            ],
          ),
        ),
      ),
    );
  }
}
