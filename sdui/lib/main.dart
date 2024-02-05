import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdui/required_fields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget content = Container();
  Widget generatedRequestData = const Text("No generated request data!");

  @override
  void initState() {
    super.initState();

    //  call getFields
    getFields();
  }

  void generateJsonRequest(Map<String, TextEditingController> controllers) {
    Map<String, dynamic> json = {};
    controllers.forEach((key, value) {
      json.addAll({key: value.text});
    });
    print("GENERATED JSON: $json");
    generatedRequestData = Text("GENERATED JSON: $json");
    setState(() {});
  }

  List<Widget> generateContent(var response) {
    List<Widget> children = [];
    Map<String, TextEditingController> controllers = {};
    List<RequiredFields> requiredFields = [];
    for (var item in jsonDecode(response.body)) {
      requiredFields.add(RequiredFields.fromJson(item));
    }

    for (RequiredFields item in requiredFields) {
      controllers.addAll({item.fieldName.toString(): TextEditingController()});
      children.add(Row(
        children: [
          Text(item.fieldDisplay.toString()),
          const SizedBox(
            width: 30,
          ),
          SizedBox(
            width: 700,
            child: TextField(
              controller: controllers[item.fieldName.toString()],
            ),
          ),
        ],
      ));
    }
    children.add(
      Column(
        children: [
          TextButton(
            onPressed: () {
              generateJsonRequest(controllers);
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
    return children;
  }

  getErrorContent() {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Error Loading"),
        ],
      ),
    );
  }

  void getFields() async {
    //  request fields in server
    try {
      // Change IP and port depending on your GoLang service IP and port
      final response = await http.get(Uri.parse('http://192.168.0.26:8000/api/v1/getRequiredFields'));

      if (response.statusCode == 200) {
        //  parse response
        content = Column(
          children: generateContent(response),
        );
        setState(() {});
      } else {
        content = getErrorContent();
        setState(() {});
      }
    } catch (e) {
      content = getErrorContent();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: content.toString() == "Container"
          ? const SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Loading"),
                ],
              ),
            )
          : Column(
              children: [
                content,
                generatedRequestData,
              ],
            ),
    );
  }
}
