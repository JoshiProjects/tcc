import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/views/login.dart';
import 'package:tcc/views/cadastro.dart';
import 'package:tcc/views/user_list.dart';
import 'package:tcc/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        AppRoutes.HOME: (_) => LoginPage(),
        AppRoutes.USER_CADASTRO: (_) => Cadastro(),
        AppRoutes.USER_LIST: (_) => UserList(),
      },
    );
  }
}
