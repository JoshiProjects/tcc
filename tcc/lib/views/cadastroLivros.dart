import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc/services/auth_service.dart';

class cadastroLivros extends StatefulWidget {
  const cadastroLivros({super.key});

  @override
  State<cadastroLivros> createState() => _cadastroLivrosState();
}

class _cadastroLivrosState extends State<cadastroLivros> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _editoraController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: true);
    late final CollectionReference _livros = FirebaseFirestore.instance
        .collection("Usuarios/${auth.usuario!.uid}/livros");
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
                    "Salvar livro",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: TextFormField(
                      controller: _tituloController,
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
                        labelText: "Título",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Digite um título';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: TextFormField(
                      controller: _autorController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(50)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3),
                              borderRadius: BorderRadius.circular(50)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(50)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3),
                              borderRadius: BorderRadius.circular(50)),
                          labelText: "Autor"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Digite o autor do livro';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: TextFormField(
                      controller: _editoraController,
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
                        labelText: "Editora",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Digite o nome da editora';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(24.0),
                      child: ElevatedButton(
                        // child: Text("Registrar"),
                        onPressed: () async {
                          final String titulo = _tituloController.text;
                          final String autor = _autorController.text;
                          final String editora = _editoraController.text;

                          if (formKey.currentState!.validate()) {
                            await _livros.doc(titulo).set({
                              "titulo": titulo,
                              "autor": autor,
                              "editora": editora
                            });
                            _tituloController.text = '';
                            _autorController.text = '';
                            _editoraController.text = '';
                            loading = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => cadastroLivros()));
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
                                        "Registrar",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ]),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
