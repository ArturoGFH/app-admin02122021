import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:project_final/Views/ListUsers.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controllerUsuario = TextEditingController();
  final controllerPassword = TextEditingController();
  String  decodePwd="";
  
  


  var url = Uri.parse('https://yoenvio.synology.me/ITI1005/oauth/?oauth');

  Future<void> login(BuildContext context) async {
    if (controllerUsuario.text.isNotEmpty && controllerPassword.text.isNotEmpty) {
      final response = await http.post(url, body: {
      "user": controllerUsuario.text,
      "password": decodePwd,
      });

      var body = json.decode(response.body);
     // print(jsonResponse.containsKey("key"););
     if(body.containsKey("fail")){
       snackbarM("Usuario incorrecto");
     }else if(body.containsKey("fail_pwd")){
       snackbarM("Contraseña incorrecta");
     }else if(body.containsKey("data")){
       _navigateToNextScreen(context);
     }
    }else{
      snackbarM("Campos de usuario y contraseña vacios");
    }
    
      
    }

     void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListUsers()));
  }

  void snackbarM (String text) {
   final snackBar = SnackBar(content: Text(text));
   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: Center(
                child: Container(
                    width: 350,
                    height: 250,
                    child: Image.asset("assets/img/logo.jpg")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 80, bottom: 15),
              child: Container(
                  width: 400,
                  child: TextField(
                    controller: controllerUsuario,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Usuario',
                        hintText: ''),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: Container(
                  width: 400,
                  child: TextField(
                    controller: controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contraseña',
                        hintText: ''),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  print(controllerUsuario.text);
                  print(controllerPassword.text);
                  if(controllerPassword.text.isNotEmpty){
                          var bytes = utf8.encode(controllerPassword.text);
                          var base64Str = base64.encode(bytes);
                          print(base64Str.toString());
                          decodePwd=base64Str.toString();
                        }
                        login(context);
                },
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  

}


