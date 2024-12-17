import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class CustomImageBox extends StatefulWidget {
  File? imageFile;
  final VoidCallback? onRemove;

  CustomImageBox({
    super.key,
    this.imageFile,
    this.onRemove,
  });

  @override
  State<CustomImageBox> createState() => _CustomImageBoxState();
}

class _CustomImageBoxState extends State<CustomImageBox> {
  late File? _imageFile;
  late var _image;
  late int _width;
  late int _height;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;

    if (_imageFile != null) {
      _loadImageInfo().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: _imageFile != null
                ? Stack(
                    children: [
                      Image.file(
                        _imageFile!,
                        width: 250,
                        height: (_height / _width) * 250,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () => _removeItem(),
                          icon: const Icon(Icons.close, color: Colors.red),
                        ),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
          );
  }

  Future<void> _loadImageInfo() async {
    _image = await decodeImageFromList(_imageFile!.readAsBytesSync());
    _width = _image.width;
    _height = _image.height;
    print(_width);
    print(_height);
  }

  Future<void> _removeItem() async {
    if (_imageFile != null) {
      try {
        await _imageFile!.delete();
        setState(() {
          _imageFile = null;
        });
        print('File deleted successfully!');
        if (widget.onRemove != null) {
          widget.onRemove!();
        }
      } catch (e) {
        print('Error deleting file: $e');
      }
    }
  }
}
