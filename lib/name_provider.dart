import 'dart:math';

import 'package:flutter/material.dart';

class NameProvider extends ChangeNotifier {
  final List<TextEditingController> _textList = [TextEditingController()];

  List<TextEditingController> get textList => _textList;

  GlobalKey<FormState> formKey = GlobalKey();

  set addTextField(TextEditingController value) {
    textList.add(value);
    notifyListeners();
  }

  void disposeControllers() {
    for (TextEditingController value in _textList) {
      value.dispose();
    }
  }

  set removeTextField(int index) {
    textList.removeAt(index);
    notifyListeners();
  }

  initTextField() {
    var random = Random();

    var value = random.nextInt(10);
    print(value);

    for (int i = 0; i < value - 1; i++) {
      textList.add(TextEditingController());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  submitForm() {
    final payload = {};

    List<String> tempList = [];

    if (formKey.currentState!.validate()) {
      for (TextEditingController value in _textList) {
        tempList.add(value.text);
      }
      payload['studentNames'] = tempList;
    }
    print(payload);
  }
}
