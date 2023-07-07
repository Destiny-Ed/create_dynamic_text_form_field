import 'package:dummy_text_app/providers/field_provider.dart';
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
      providers: [
        ChangeNotifierProvider(create: (_) => FieldProvider()),
      ],
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
  void initState() {
    super.initState();

    Provider.of<FieldProvider>(context, listen: false).generateInitialFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
      ),
      body: Consumer<FieldProvider>(builder: (context, model, _) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                ...List.generate(model.textList.length, (index) {
                  final controller = model.textList[index];
                  return TextFormField(
                    controller: controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Child's Name ${index + 1}",
                        suffixIcon: index == 0
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  model.removeTextField = index;
                                },
                                child: const Icon(Icons.delete))),
                  );
                }),

                ///Add more button
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          model.addTextField = TextEditingController();
                        },
                        child: const Text("Add More"))),

                ///Validate fields
                TextButton(
                    onPressed: () {
                      model.submitForms();
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        );
      }),
    );
  }
}
