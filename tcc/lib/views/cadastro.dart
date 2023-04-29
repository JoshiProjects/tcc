import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:provider/provider.dart';

class Cadastro extends StatefulWidget {
  @override
  CadastroState createState() {
    return CadastroState();
  }
}

class CadastroState extends State<Cadastro> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  @override
  Widget build(BuildContext) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Color(0xFF530C74),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 40,
              left: 100,
              right: 100,
              child: Text(
                'Cadastre-se',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 125,
              left: 35,
              right: 35,
              bottom: 100,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 45, horizontal: 35),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(192, 143, 0, 209),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Preencha este campo';
                              }
                              return null;
                            },
                            onSaved: (value) => _formData['name'] = "$value",
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                              )),
                              hintText: 'Nome',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 35),
                          child: TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Preencha este campo';
                                }
                                return null;
                              },
                              onSaved: (value) => _formData['email'] = "$value",
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white54)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 75),
                          child: TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Preencha este campo';
                                }
                                return null;
                              },
                              onSaved: (value) => _formData['senha'] = "$value",
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white54)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'Senha',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ))),
                        ),
                        Container(
                          height: 45,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35))),
                          child: Center(
                              child: Text(
                            'Cadastrar',
                            style: TextStyle(color: Color(0xFF530C74)),
                          )),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
