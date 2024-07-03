import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/controller/home_prov.dart';
import 'package:wolf_pack_test/services/database_services.dart';

connectionsTile({
  required BuildContext context,
  required dynamic userData,
}) {
  return userData["uid"] != DatabaseService().getCurrentUser()!.uid
      ? GestureDetector(
          onTap: () {
            Provider.of<HomeProv>(context, listen: false)
                .getMessage(context, userData: userData);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: userData['profilePic'].isNotEmpty
                    ? NetworkImage(userData['profilePic'])
                    : null,
                backgroundColor: kprimary,
                child: userData['profilePic'].isNotEmpty
                    ? null
                    : Text(
                        userData["fullName"].substring(0, 1).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: kWhite, fontWeight: FontWeight.w500),
                      ),
              ),
              title: Text(
                userData["fullName"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                "Join the conversation",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        )
      : const SizedBox();
}
