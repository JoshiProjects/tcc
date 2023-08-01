import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tcc/services/auth_service.dart';
import 'package:tcc/services/imageCropperPage.dart';
import 'package:tcc/services/imagePickerClass.dart';
import 'package:tcc/views/reconhecimento.dart';
import 'package:tcc/widgets/modalDialog.dart';

class citacoesPage extends StatelessWidget {
  const citacoesPage({super.key, required this.livro});
  final String livro;

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: true);
    late final CollectionReference _citacoes = FirebaseFirestore.instance
        .collection("Usuarios/${auth.usuario!.uid}/livros/${livro}/citacoes");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF530C74),
        title: Text('${livro}'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF530C74),
        onPressed: () => imagePickerModal(context, onCameratap: () {
          print("Camera");
          pickImage(source: ImageSource.camera).then((value) {
            if (value != '') {
              imageCropperView(value, context).then((value) {
                if (value != '') {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => reconhecimentoPage(
                        livro: livro,
                        path: value,
                      ),
                    ),
                  );
                }
              });
            }
          });
        }, onGaleriaTap: () {
          print("Galeria");
          pickImage(source: ImageSource.gallery).then((value) {
            if (value != '') {
              imageCropperView(value, context).then((value) {
                if (value != '') {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => reconhecimentoPage(
                        livro: livro,
                        path: value,
                      ),
                    ),
                  );
                }
              });
            }
          });
        }),
        label: Text("scan livro"),
        tooltip: "Incremento",
      ),
      body: StreamBuilder(
        stream: _citacoes.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          if (snapshots.hasData && snapshots.data!.docs.length != 0) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshots.data!.docs[index];
                final avatar = CircleAvatar(
                    backgroundColor: Color(0xFF530C74),
                    child: Icon(
                      Icons.abc_outlined,
                      color: Colors.white,
                    ));

                return Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(72, 175, 70, 228),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: GridTile(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('${documentSnapshot['citacao']}'),
                            ),
                          ),
                          footer: Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'pág ${documentSnapshot['pagina']}',
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // style: TextStyle(
                          //   fontSize: 10,
                          //   fontWeight: FontWeight.bold,
                          header: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: avatar,
                            ),
                          ),
                        )));
              },
            );
            // ListView.builder(
            //   itemCount: snapshots.data!.docs.length,
            //   itemBuilder: (context, index) {
            //     final DocumentSnapshot documentSnapshot =
            //         snapshots.data!.docs[index];
            //     final avatar = CircleAvatar(child: Icon(Icons.abc_outlined));
            //     return Card(
            //       child: ListTile(
            //         leading: avatar,
            //         title: Text('${documentSnapshot['citacao']}'),
            //         subtitle: Text('pág ${documentSnapshot['pagina']}'),
            //         trailing: Container(
            //           width: 50,
            //           child: Row(
            //             children: <Widget>[
            //               IconButton(
            //                 onPressed: () => {},
            //                 icon: Icon(Icons.edit),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
            // return Center(
            //   child: Text("Existe livros cadastrados!"),
            // );
          } else {
            return Center(
              child: Text("sem citações por enquanto!"),
            );
          }
        },
      ),
    );
  }
}
