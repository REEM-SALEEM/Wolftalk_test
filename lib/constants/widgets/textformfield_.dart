import 'package:flutter/material.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/constants/styles/textform_styles.dart';

textFormField({
  TextEditingController? controller,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  String? hintText,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      isDense: true,
      filled: true,
      fillColor: kGrey,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color.fromARGB(255, 163, 103, 103)),
      ),
    ),
  );
}

Widget customText({required String text}) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Text(text, style: kHintTitleStyle),
  );
}
