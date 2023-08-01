import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';
import 'package:tcc/services/auth_service.dart';
import 'package:tcc/views/citacoes.dart';

class reconhecimentoPage extends StatefulWidget {
  final String? path;
  final String? livro;
  const reconhecimentoPage({Key? key, this.path, required this.livro});

  @override
  State<reconhecimentoPage> createState() => _reconhecimentoPageState();
}

class _reconhecimentoPageState extends State<reconhecimentoPage> {
  bool _isBusy = false;
  final TextEditingController _citacaoController = TextEditingController();
  final TextEditingController _paginaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processandoImagem(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: true);
    late final CollectionReference _citacoes = FirebaseFirestore.instance
        .collection(
            "Usuarios/${auth.usuario!.uid}/livros/${widget.livro}/citacoes");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF530C74),
          title: Text("Reconhecimento de Texto"),
        ),
        body: _isBusy == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Salvar Citação",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1.5,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 400,
                              ),
                              child: TextFormField(
                                controller: _citacaoController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3),
                                      borderRadius: BorderRadius.circular(50)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 3),
                                      borderRadius: BorderRadius.circular(50)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3),
                                      borderRadius: BorderRadius.circular(50)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 3),
                                      borderRadius: BorderRadius.circular(50)),
                                  labelText: "Transcreva a citação",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Transcreva a citação';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 400,
                              ),
                              child: TextFormField(
                                controller: _paginaController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3),
                                      borderRadius: BorderRadius.circular(50)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 3),
                                      borderRadius: BorderRadius.circular(50)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3),
                                      borderRadius: BorderRadius.circular(50)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 3),
                                      borderRadius: BorderRadius.circular(50)),
                                  labelText: "Página",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Digite a página da citação';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(24.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shadowColor:
                                        Color.fromARGB(255, 102, 95, 105),
                                    backgroundColor: Color(0xFF530C74),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    )),
                                // child: Text("Registrar"),
                                onPressed: () async {
                                  final String citacao =
                                      _citacaoController.text;
                                  final String pagina = _paginaController.text;
                                  if (formKey.currentState!.validate()) {
                                    await _citacoes.doc().set({
                                      "citacao": citacao,
                                      "pagina": pagina,
                                    });
                                    _citacaoController.text = '';
                                    _paginaController.text = '';
                                    loading = true;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => citacoesPage(
                                                  livro: widget.livro!,
                                                )));
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
                                                child:
                                                    CircularProgressIndicator(
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
                              ))
                        ]),
                  ),
                ),
              ));
  }

  void processandoImagem(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    _citacaoController.text = recognizedText.text;

    setState(() {
      _isBusy = false;
    });
  }
}
