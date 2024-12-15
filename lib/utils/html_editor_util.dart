import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorUtil extends StatefulWidget {
  final String title;

  const HtmlEditorUtil({super.key, required this.title});

  @override
  State<HtmlEditorUtil> createState() => _HtmlEditorUtilState();
}

class _HtmlEditorUtilState extends State<HtmlEditorUtil> {
  String result = '';
  final ImagePicker _imagePicker = ImagePicker();
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0,
          actions: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if (kIsWeb) {
                    controller.reloadWeb();
                  } else {
                    controller.editorController!.reload();
                  }
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: '내용을 입력 하세요...',
                  shouldEnsureVisible: true,
                  //initialText: "<p>text content initial, if any</p>",
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  defaultToolbarButtons: [
                    const ColorButtons(),
                    const ListButtons(),
                    const InsertButtons(
                      video: false,
                      audio: false,
                      table: false,
                      hr: false,
                      otherFile: false,
                      link: false,
                    ),
                  ],
                  toolbarPosition: ToolbarPosition.aboveEditor,
                  toolbarType: ToolbarType.nativeGrid,
                  onButtonPressed:
                      (ButtonType type, bool? status, Function? updateStatus) {
                    if (type == ButtonType.picture) {
                      _pickAndInsertImage();
                      return false;
                    }
                    return true;
                  },
                  onDropdownChanged: (DropdownType type, dynamic changed,
                      Function(dynamic)? updateSelectedItem) {
                    return true;
                  },
                  mediaLinkInsertInterceptor:
                      (String url, InsertFileType type) {
                    return true;
                  },
                  mediaUploadInterceptor:
                      (PlatformFile file, InsertFileType type) async {
                    return true;
                  },
                ),
                otherOptions: const OtherOptions(height: double.infinity),
                callbacks: Callbacks(
                    onBeforeCommand: (String? currentHtml) {},
                    onChangeContent: (String? changed) {},
                    onChangeCodeview: (String? changed) {},
                    onChangeSelection: (EditorSettings settings) {},
                    onDialogShown: () {},
                    onEnter: () {},
                    onFocus: () {},
                    onBlur: () {},
                    onBlurCodeview: () {},
                    onInit: () {},
                    onImageUploadError: (FileUpload? file, String? base64Str,
                        UploadError error) {
                      if (file != null) {}
                    },
                    onKeyDown: (int? keyCode) {},
                    onKeyUp: (int? keyCode) {},
                    onMouseDown: () {},
                    onMouseUp: () {},
                    onNavigationRequestMobile: (String url) {
                      return NavigationActionPolicy.ALLOW;
                    },
                    onPaste: () {},
                    onScroll: () {}),
                plugins: [
                  SummernoteAtMention(
                      getSuggestionsMobile: (String value) {
                        var mentions = <String>['test1', 'test2', 'test3'];
                        return mentions
                            .where((element) => element.contains(value))
                            .toList();
                      },
                      mentionsWeb: ['test1', 'test2', 'test3'],
                      onSelect: (String value) {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _pickAndInsertImage() async {
    final XFile? image =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final String extension = image.path.split('.').last;
      final bytes = await image.readAsBytes();
      final base64Data = base64Encode(bytes);

      controller.insertHtml(
          "<img width='40%' src='data:image/$extension;base64,$base64Data' alt=''/>");

      return true;
    }

    return false;
  }
}
