import 'dart:math';

import 'package:flutter/material.dart';

class FieldProvider extends ChangeNotifier {
  final List<TextEditingController> _textList = [TextEditingController()];

  List<TextEditingController> get textList => _textList;

  final GlobalKey<FormState> formKey = GlobalKey();

  set addTextField(TextEditingController value) {
    _textList.add(value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  set removeTextField(int index) {
    _textList.removeAt(index);
    notifyListeners();
  }

  generateInitialFields() {
    int rand = Random().nextInt(10);

    print(rand);

    for (int i = 0; i < rand - 1; i++) {
      addTextField = TextEditingController();
    }
  }

  void submitForms() {
    var payload = {};

    List<String> tempList = [];
    if (formKey.currentState!.validate()) {
      print("All is validated");
      for (TextEditingController controller in _textList) {
        print(controller.text);
        tempList.add(controller.text);
      }
      payload['children_name'] = tempList;

      print(payload);
    }
  }
}
