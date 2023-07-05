import 'dart:math';

import 'package:dummy_text_app/name_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NameProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();

    if (mounted) {
      Provider.of<NameProvider>(context, listen: false).disposeControllers();
    }
  }

  @override
  void initState() {
    super.initState();

    Provider.of<NameProvider>(context, listen: false).initTextField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nothing"),
      ),
      body: Consumer<NameProvider>(builder: (context, model, _) {
        return Form(
          key: model.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Add names of your children

                  ///TextFormWidget
                  ...List.generate(model.textList.length, (index) {
                    final controller = model.textList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name ${index + 1}",
                          suffixIcon: index == 0
                              ? null
                              : GestureDetector(
                                  onTap: () {
                                    model.removeTextField = index;
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                        ),
                      ),
                    );
                  }),

                  Align(
                    alignment: Alignment.topRight,
                    child: Card(
                      color: Colors.amber,
                      child: GestureDetector(
                        onTap: () {
                          model.addTextField = TextEditingController();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                          width: MediaQuery.sizeOf(context).width / 4,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Add more",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///Button
                  const SizedBox(
                    height: 40,
                  ),

                  GestureDetector(
                    onTap: () {
                      model.submitForm();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.amber,
                      padding: const EdgeInsets.all(10),
                      child: const Text("Submit"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
