import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        _handleKeyPress(event);
      },
      child: TextField(
        maxLines: null,
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
      ),
    );
  }

  void _handleKeyPress(KeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        print('Backspace key pressed!');
      }
      // Add other key handling if needed
    }
  }
}
