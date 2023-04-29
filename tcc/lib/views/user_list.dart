import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final CollectionReference _usuarios =
      FirebaseFirestore.instance.collection('Usuarios');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
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
                    child: const Text('Editar'),
                    onPressed: () async {
                      final String email = _emailController.text;
                      final String senha = _senhaController.text;

                      if (senha != null) {
                        await _usuarios
                            .doc(documentSnapshot!.id)
                            .update({"email": email, "senha": senha});
                      }
                    },
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de usuário'),
        ),
        body: StreamBuilder(
          stream: _usuarios.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  final avatar = CircleAvatar(child: Icon(Icons.person));
                  return Card(
                    child: ListTile(
                      leading: avatar,
                      title: Text(documentSnapshot['email']),
                      subtitle: Text(documentSnapshot['senha']),
                      trailing: Container(
                        width: 50,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () => _update(documentSnapshot),
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text("");
            }
          },
        ));
  }
}
// if (value == null || value.trim().isEmpty) {
//                                   return 'Preencha este campo';
//                                 }
//                                 return null;
//                               },
