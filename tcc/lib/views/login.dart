import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/main.dart';
import 'package:tcc/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final CollectionReference _usuarios =
      FirebaseFirestore.instance.collection('Usuarios');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _emailController.text = documentSnapshot['email'];
      _senhaController.text = documentSnapshot['senha'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _senhaController,
                    decoration: const InputDecoration(labelText: 'Senha'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Salvar'),
                    onPressed: () async {
                      final String email = _emailController.text;
                      final String senha = _senhaController.text;

                      if (senha != null) {
                        await _usuarios.add({"email": email, "senha": senha});
                        _emailController.text = '';
                        _senhaController.text = '';
                      }
                    },
                  )
                ],
              ));
        });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/banner_login.jpg",
              width: 400,
            ),
            Positioned(
              top: 145,
              left: 35,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 45, horizontal: 35),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0xFF530C74),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45)),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                        decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 75),
                      child: TextField(
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: 'Senha',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.USER_LIST);
                          },
                          child: Container(
                            height: 45,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35))),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Color(0xFF530C74)),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextButton(
                        onPressed: () => _create(),
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
