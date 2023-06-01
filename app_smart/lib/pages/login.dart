import 'package:app_smart/pages/abertura.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:app_smart/pages/pagina1.dart';
import 'package:app_smart/pages/salvamento.dart';
import 'package:app_smart/pages/cadastro.dart';

class login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<login> {
  String email = "";
  String senha = "";
  String url = 'http://34.234.92.215:8000/api/user/token/';
  bool lembrarConta = false;
  bool valor = false;
  String token = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,

      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.asset("assets/smart_logo.png"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  senha = value;
                });
              },
              style: TextStyle(fontSize: 20),
            ),
            CheckboxRow(
              lembrarConta: lembrarConta,
              onChanged: (bool value) {
                setState(() {
                  lembrarConta = value;
                  if(lembrarConta == true){
                    armazenamento(token);
                    print("Token salvo: " + token);
                  }else{
                  }
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    Map<String, String> headers = {'Content-Type': 'application/json'};
                    Map<String, String> body = {'email': email, 'password': senha};

                    http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      // Requisição bem-sucedida, processar a resposta da API
                      String responseBody = response.body;

                      // Converter a resposta JSON em um mapa
                      Map<String, dynamic> data = jsonDecode(responseBody);

                      print(data);

                      // Supondo que a API retorna um token de autenticação
                      token = data['token'];
                      //print(token);

                      // Verificar se o usuário está autenticado com base no token
                      if (token != null && token.isNotEmpty) {
                        armazenamento(token);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => pagina1(),
                          ),
                        );
                      } else {
                        // Usuário não autenticado
                        // Lidar com o erro de autenticação
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Atencao!"),
                              content: Text("Usuario ou senha incorreta"),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Tente novamente"),
                                ),
                              ],
                            );
                          }
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Column(
                children: [
                  Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cadastro",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                      PageTransition(
                        currentPage: login(),
                        nextPage: cadastro(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void armazenamento(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("authToken", value);
  }
}

class CheckboxRow extends StatefulWidget {
  final bool lembrarConta;
  final Function(bool) onChanged;

  CheckboxRow({required this.lembrarConta, required this.onChanged});

  @override
  _CheckboxRowState createState() => _CheckboxRowState();
}

class _CheckboxRowState extends State<CheckboxRow> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.lembrarConta;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
              widget.onChanged(isChecked);
            });
          },
        ),
        Text(
          "Lembrar conta",
          style: TextStyle(
            color: Colors.black38,
          ),
        ),
        Spacer(),
        Container(
          height: 40,
          alignment: Alignment.centerRight,
          child: TextButton(
            child: Text(
              "Esqueceu a senha?",
              style: TextStyle(
                color: Colors.black38,
              ),
              textAlign: TextAlign.right,
            ),
            onPressed: () {

            },
          ),
        ),
      ],
    );
  }
}
