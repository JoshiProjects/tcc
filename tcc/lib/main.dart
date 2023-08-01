import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:tcc/components/checagem.dart';
import 'package:tcc/routes/routes.dart';
import 'package:tcc/services/auth_service.dart';
import 'package:tcc/views/cadastroLivros.dart';
import 'package:tcc/views/homePage.dart';
import 'package:tcc/views/login.dart';
import 'package:tcc/views/user_list.dart';
import 'package:tcc/widgets/auth_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (conext) => homePage()),
      ],
      child: MyApp(),
    ),
  );

  // void FirebaseAuth.instance.idTokenChanges().listen((User? user) {
  //   if (user == null) {
  //     Navigator.of(context).pushNamed(AppRoutes.LOGIN);
  //   } else {
  //     Navigator.of(context).pushNamed(AppRoutes.HOME);
  //   }
  // });
}
//flutter build apk --split-per-abi - gerar apk
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: AuthCheck(),
      routes: {
        AppRoutes.USER_LIST: (_) => UserList(),
        AppRoutes.LOGIN: (_) => LoginPage(),
        AppRoutes.CADASTRO_LIVROS: (_) => cadastroLivros(),
        // AppRoutes.HOME: (_) => AuthCheck(),
      },
    );
  }
}
