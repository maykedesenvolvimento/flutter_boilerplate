import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/form/views/form.dart';
import 'package:flutter_boilerplate/delivery_model.dart';
import 'app/definitions/text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final data = DeliveryModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.build(
                'Form example',
                size: 25,
                weight: FontWeight.w700,
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 800,
                child: AppForm(
                  data: data,
                  onSave: (data) => print(data),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
