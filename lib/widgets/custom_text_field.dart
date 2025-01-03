import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  int lineNumber;
  bool isVisible;
  TextEditingController textEditingController;

  CustomTextField({
    super.key,
    required this.lineNumber,
    required this.isVisible,
    required this.textEditingController,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late int _lineNumber;
  late TextEditingController textEditingController;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _lineNumber = widget.lineNumber;
    _isVisible = widget.isVisible;
    textEditingController = widget.textEditingController;
  }

  void _handleKeyEvent(KeyEvent e) {
    if (textEditingController.text.isEmpty
        && e.logicalKey == LogicalKeyboardKey.backspace
        && 1 != _lineNumber
    ) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (KeyEvent e) => _handleKeyEvent(e),
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
          )
        : const SizedBox.shrink();
  }
}
