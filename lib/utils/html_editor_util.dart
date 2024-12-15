import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorUtil extends StatefulWidget {
  const HtmlEditorUtil({super.key, required this.appBar});

  final AppBar appBar;

  @override
  _HtmlEditorUtilState createState() => _HtmlEditorUtilState();
}

class _HtmlEditorUtilState extends State<HtmlEditorUtil> {
  late final AppBar _appBar;
  final ImagePicker _imagePicker = ImagePicker();
  final HtmlEditorController _controller = HtmlEditorController();

  @override
  void initState() {
    super.initState();
    _appBar = widget.appBar;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          _controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: _appBar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                child: const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '제목',
                        ),
                        enabled: true,
                      ),
                    ),
                  ],
                ),
              ),
              HtmlEditor(
                controller: _controller,
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
                otherOptions: const OtherOptions(height: 1500),
                callbacks: Callbacks(
                    onBeforeCommand: (String? currentHtml) {},
                    onChangeContent: (String? changed) {},
                    onChangeCodeview: (String? changed) {},
                    onChangeSelection: (EditorSettings settings) {},
                    onDialogShown: () {},
                    onEnter: () {},
                    onFocus: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _controller.setFocus();
                    },
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

      _controller.insertHtml(
          "<img width='40%' src='data:image/$extension;base64,$base64Data'/>");

      return true;
    }

    return false;
  }
}
