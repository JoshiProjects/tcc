import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc/services/auth_service.dart';
import 'package:tcc/views/login.dart';
import 'package:tcc/views/homePage.dart';


class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return Loading();
    else if (auth.usuario == null)
      return LoginPage();
    else
      return HomePage();
  }

  Loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
