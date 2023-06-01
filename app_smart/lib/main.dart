import 'package:flutter/material.dart';
import 'package:app_smart/pages/login.dart';
import 'package:app_smart/pages/pagina1.dart';
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    meuApp(),
  );
}
class meuApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: login(),
      routes: {
        "login": (context) => login(),
        "pagina1": (context) => pagina1(),
      },
    );
  }
}