import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes2/injection.dart';
import 'package:notes2/presentation/core/app.dart';

// ignore: avoid_void_async
void main() async {
  configureDependencies(Environment.dev);

  //start firebase auth
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(AppWidget());
}
