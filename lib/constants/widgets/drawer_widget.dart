import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/constants/styles/textform_styles.dart';
import 'package:wolf_pack_test/controller/home_prov.dart';
import 'package:wolf_pack_test/controller/login_prov.dart';

drawerWidget() {
  return Drawer(
    child: Consumer<HomeProv>(builder: (context, value, child) {
      return ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            value.snapshot != null &&
                    value.snapshot!.docs[0]['profilePic'] != null &&
                    value.snapshot!.docs[0]['profilePic'].isNotEmpty
                ? CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage(
                      value.snapshot!.docs[0]['profilePic'],
                    ),
                  )
                : Icon(
                    Icons.account_circle,
                    size: 150,
                    color: Colors.grey[700],
                  ),
            const SizedBox(height: 15),
            Text(
              value.sName ?? 'ds',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Divider(height: 2),
            drawerChildWidget(
              onTap: () {
                Navigator.pop(context);
              },
              title: 'Groups',
              icon: Icons.group,
            ),
            drawerChildWidget(
              onTap: () {
                Navigator.of(context).pushNamed('/profile_screen');
              },
              title: 'Profile',
              icon: Icons.person,
            ),
            drawerChildWidget(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "Logout",
                          style: kMainTitleStyle,
                        ),
                        content: const Text(
                          "Are you sure you want to logout?",
                          style: kHintTitleStyle,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: kprimary),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<LoginProv>(context, listen: false)
                                  .signOut(context);
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: kprimary),
                            ),
                          ),
                        ],
                      );
                    });
              },
              title: 'Logout',
              icon: Icons.exit_to_app,
            ),
          ]);
    }),
  );
}

drawerChildWidget({
  required void Function()? onTap,
  required String title,
  required IconData icon,
}) {
  return ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    leading: Icon(icon),
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
