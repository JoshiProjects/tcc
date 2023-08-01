import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc/services/auth_service.dart';
import 'package:tcc/views/cadastroLivros.dart';
import 'package:tcc/views/citacoes.dart';

class homePage extends ChangeNotifier {}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lívros'),
//         ),
//       body: Center(
//         child: Text('Sem lívros salvos ;-;'),
//       ),
//     );
//   }
// }

//   Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
//     if (documentSnapshot != null) {
//       _emailController.text = documentSnapshot['email'];
//       _senhaController.text = documentSnapshot['senha'];
//     }
//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//               padding: EdgeInsets.only(
//                   top: 20,
//                   left: 20,
//                   right: 20,
//                   bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     keyboardType: TextInputType.emailAddress,
//                     controller: _emailController,
//                     decoration: const InputDecoration(labelText: 'Email'),
//                   ),
//                   TextField(
//                     keyboardType: TextInputType.visiblePassword,
//                     controller: _senhaController,
//                     decoration: const InputDecoration(labelText: 'Senha'),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     child: const Text('Editar'),
//                     onPressed: () async {
//                       final String email = _emailController.text;
//                       final String senha = _senhaController.text;

//                       if (senha != null) {
//                         await _usuarios
//                             .doc(documentSnapshot!.id)
//                             .update({"email": email, "senha": senha});
//                       }
//                     },
//                   )
//                 ],
//               ));
//         });
//   }

// //   //

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: true);
    late final CollectionReference _livros = FirebaseFirestore.instance
        .collection("Usuarios/${auth.usuario!.uid}/livros");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF530C74),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthService>().Logout();
            },
          ),
        ],
        title: Text('Lista de Lívros'),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF530C74),
          shape: CircleBorder(),
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => cadastroLivros())),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: _livros.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF530C74),
              ),
            );
          }
          if (snapshots.hasData && snapshots.data!.docs.length != 0) {
            return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshots.data!.docs[index];
                final avatar = CircleAvatar(
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                  ),
                  backgroundColor: Color(0xFF530C74),
                );
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(72, 175, 70, 228),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => citacoesPage(
                                  livro: documentSnapshot['titulo']),
                            ));
                      },
                      leading: avatar,
                      title: Text('${documentSnapshot['titulo']}'),
                      subtitle: Text('Autor: ${documentSnapshot['autor']}'),
                      trailing: Container(
                        width: 50,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.mode_edit_rounded),
                            ),
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.delete_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
            // return Center(
            //   child: Text("Existe livros cadastrados!"),
            // );
          } else {
            return Center(
              child: Text("sem livros cadastrados!"),
            );
          }
        },
      ),
    );
  }
}
