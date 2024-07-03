import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/constants/size/size.dart';
import 'package:wolf_pack_test/constants/styles/textform_styles.dart';
import 'package:wolf_pack_test/constants/widgets/elevatedbutton.dart';
import 'package:wolf_pack_test/constants/widgets/textformfield_.dart';
import 'package:wolf_pack_test/controller/profile_prov.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<ProfileProv>(context, listen: false).isLoading = false;
    Provider.of<ProfileProv>(context, listen: false).getUserDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Your Account',
          style: kMainTitleStyle.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Consumer<ProfileProv>(builder: (context, value, child) {
            return StreamBuilder(
              stream: null,
              builder: (context, snapshot) {
                return value.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            value.snapshot != null &&
                                    value.snapshot!.docs[0]['profilePic'] !=
                                        null &&
                                    value.snapshot!.docs[0]['profilePic']
                                        .isNotEmpty
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        value.snapshot!.docs[0]['profilePic']),
                                  )
                                : Icon(
                                    Icons.account_circle,
                                    size: 150,
                                    color: Colors.grey[700],
                                  ),
                            kHeight35,
                            textFormField(
                                controller: value.fullNameController,
                                hintText: 'Name'),
                            kHeight15,
                            value.sEmail != null
                                ? textFormField(
                                    enabled: false,
                                    controller: value.emailController,
                                    hintText: 'Email')
                                : textFormField(
                                    enabled: false,
                                    controller: value.mobileController,
                                    hintText: 'Mobile Number'),
                            kHeight15,
                            textFormField(
                                controller: value.bioController,
                                hintText: 'About'),
                            kHeight50,
                            elevatedButton(
                                onPressed: () {
                                  value.updateUserDetails();
                                },
                                hintText: 'SAVE DETAILS'),
                            kHeight35,
                            const Divider(),
                            kHeight10,
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'DELETE ACCOUNT',
                                  style: TextStyle(color: kprimary),
                                ))
                          ],
                        ),
                      );
              },
            );
          })),
    );
  }
}
