import 'package:app_smart/pages/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_smart/pages/salvamento.dart';
import 'package:app_smart/pages/abertura.dart';

class pagina1 extends StatefulWidget{
  @override
  State<pagina1> createState() => _pagina1State();
}

class _pagina1State extends State<pagina1>{
  String valorToken = "";

  SharedPref sharedPref = SharedPref();

  void initState(){
    super.initState();
    sharedPref.read('authToken').then((jsonString) {
      setState(() {
        valorToken = jsonString;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.of(context).push(
                PageTransition(
                  currentPage: pagina1(),
                  nextPage: menu(),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        title: Text("Pagina 1"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(valorToken),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}