import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;

  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;

      if (isLogin) {
        titulo = 'Login';
        actionButton = 'Logar';
        toggleButton = 'Ainda não tem conta? Crie uma agora';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Já tem conta?';
      }
    });
  }

  Login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().Login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Registrar() async {
    try {
      setState(() => loading = true);
      await context.read<AuthService>().Registrar(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3),
                            borderRadius: BorderRadius.circular(50)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3),
                            borderRadius: BorderRadius.circular(50)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3),
                            borderRadius: BorderRadius.circular(50)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3),
                            borderRadius: BorderRadius.circular(50)),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: TextFormField(
                      controller: senha,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3),
                            borderRadius: BorderRadius.circular(50)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3),
                            borderRadius: BorderRadius.circular(50)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3),
                            borderRadius: BorderRadius.circular(50)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3),
                            borderRadius: BorderRadius.circular(50)),
                        labelText: 'Senha',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha';
                        } else if (value.length < 8) {
                          return 'Sua senha deve ter no minimo 8 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Color.fromARGB(255, 102, 95, 105),
                          backgroundColor: Color(0xFF530C74),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          )),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (isLogin) {
                            Login();
                          } else {
                            Registrar();
                          }
                        }
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: (loading)
                              ? [
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ]
                              : [
                                  Icon(Icons.check),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      actionButton,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ]),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setFormAction(!isLogin),
                    child: Text(toggleButton,
                        style: TextStyle(
                          color: Color(0xFF530C74),
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
