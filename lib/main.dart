import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes2/domain/auth/value_objects.dart';
import 'package:notes2/injection.dart';

void main() {
  configureDependencies(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EmailAddress emailAddress = EmailAddress("test@calvivnellisdev");

    // emailAddress.value
    //   .fold((left) => "left is $left", (right) => "right is $right");

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text(emailAddress.value
                .fold((left) => "left is $left", (right) => "right is $right")),
          ),
        ),
      ),
    );
  }
}
