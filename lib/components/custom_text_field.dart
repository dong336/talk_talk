import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: const InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: '내용을 입력 하세요...',
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
      ),
      controller: textEditingController,
    );
  }
}
