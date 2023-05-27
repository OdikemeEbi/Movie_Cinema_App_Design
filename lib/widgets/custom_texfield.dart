import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.purple,
      onChanged: (value) {},
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.grey.shade600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black12)),

        // suffixIcon: phoneController.text.length >= 10
        //     ? Container(
        //         height: 30,
        //         width: 30,
        //         margin: const EdgeInsets.all(8.0),
        //         decoration: const BoxDecoration(
        //             shape: BoxShape.circle, color: Colors.green),
        //         child: const Icon(
        //           Icons.done,
        //           color: Colors.white,
        //           size: 20,
        //         ),
        //       )
        //     : null,
      ),
    );
  }
}
