import 'package:flutter/material.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/constants/styles/textform_styles.dart';

Widget elevatedButton({
  required void Function()? onPressed,
  required String hintText,
  double? width,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        backgroundColor: kGreen,
        minimumSize: Size(width ?? double.infinity, 50),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
    child: Text(
      hintText,
      style: kTextFormFieldStyle,
    ),
  );
}
