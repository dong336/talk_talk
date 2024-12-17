import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  int lineNumber;
  bool isVisible;

  CustomTextField({
    super.key,
    required this.lineNumber,
    required this.isVisible,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late int _lineNumber;
  bool _isVisible = true;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _lineNumber = widget.lineNumber;
    _isVisible = widget.isVisible;
  }

  void _handleKeyEvent(KeyEvent e) {
    if (e.logicalKey == LogicalKeyboardKey.backspace
        && 1 != _lineNumber) {
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
