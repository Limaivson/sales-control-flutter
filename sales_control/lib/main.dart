// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
// import 'package:sales_control/page/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sales_control/firebase_options.dart';
import 'package:sales_control/page/menu_principal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const Login());
  runApp(const Menu());
}