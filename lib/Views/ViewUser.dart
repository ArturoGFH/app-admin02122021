import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:project_final/Views/ListUsers.dart';
import 'package:flutter/material.dart';


class ViewUser extends StatefulWidget {
  
  ViewUser({Key? key}) : super(key: key);

  String _idL='';

  ServerInfo(String server) {
    this._idL = server;
    print(_idL+'####entro al metodo#######');
  }

  @override
  _ViewUserState createState() => _ViewUserState();

static void sendData(String text){
    print(text);
     if (int.parse(text)!=0) {
       print(text+"################este es el idLogin que esta recibiendo");
     }
  }
  
}

  

class _ViewUserState extends State<ViewUser> {
  final String datasaaaa='';
 

  final controllerUser = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerNoEmple = TextEditingController();
  String NoEmpleado = '';
  final controllerNombre = TextEditingController();
  String Nombre = '';
  final controllerTelefono = TextEditingController();
  String Telefono = '';
  final controllerRFC = TextEditingController();
  String RFC = '';
  final controllerDireccion = TextEditingController();
  String Direccion = '';
  final controllerNSS = TextEditingController();
  String NSS = '';
  final controllerAnio = TextEditingController();
  String Anio = '';
  final controllerDia = TextEditingController();
  String Dia = '';
  final controllerMes = TextEditingController();
  String Mes = '';
  int areaT = 0;
  String areaDT = '';
  String sexo = '';
  int valorAreaT = 0;
  int valorSexo = 0;
  DateTime fechaIngreso = DateTime.now();
  DateTime fechaSelecc = DateTime.now();
  String dateStr = 'Fecha de admisión';
  String birthday = '';
   String  decodePwd='';
   Map<String, dynamic> userData={};
   List<dynamic> workAreaA=[];

   Future<void> getDataEmploye(String idE) async {
    var response = await http.get(
      Uri.parse("https://yoenvio.synology.me/ITI1005/employe/?get&id="+idE),
      headers: {
        "Accept": "application/json"
      }
    );
    this.setState((){
        userData=json.decode(response.body)["data"];
       print("sientra"+json.decode(response.body)["data"].toString());
       print('${userData['user']}');
       controllerNoEmple.text=userData['profile']['noEmploye'].toString();
       controllerNombre.text=userData['profile']['name'].toString();
       controllerTelefono.text=userData['profile']['phone'].toString();
       controllerRFC.text=userData['profile']['rfc'].toString();
       controllerDireccion.text=userData['profile']['address'].toString();
       controllerNSS.text=userData['profile']['nss'].toString();
       print(userData['profile']['birthday'].toString());
       print(userData['profile']['birthday'].toString().substring(8, 10));
       print(userData['profile']['birthday'].toString().substring(5, 7));
       print(userData['profile']['birthday'].toString().substring(0, 4));
       controllerDia.text=userData['profile']['birthday'].toString().substring(8, 10);
       controllerMes.text=userData['profile']['birthday'].toString().substring(5, 7);
       controllerAnio.text=userData['profile']['birthday'].toString().substring(0, 4);
       dateStr=userData['profile']['dateAdmission'].toString();
       controllerUser.text=userData['user'].toString();
       decodePwdM(userData['password'].toString());
       controllerPassword.text=decodePwd;
       valorSexo=int.parse(userData['profile']['sex'].toString()); 
  
        for (var i = 0; i < workAreaA.length; i++) {
          print(">> " + workAreaA[i]["name"]);
          if (userData['profile']['workArea'].toString().toLowerCase()==workAreaA[i]["name"].toLowerCase()) {
              areaT=i+1;
              areaDT=workAreaA[i]["name"];
          }
        }
    });
  
  } 

  Future<void> getWorkArea() async {
    var response = await http.get(
      Uri.parse("https://yoenvio.synology.me/ITI1005/employe/?get&workArea"),
      headers: {
        "Accept": "application/json"
      }
    );
    this.setState((){
      print("sientraworkarea");
      workAreaA = List.from(json.decode(response.body)["data"]);
      getDataEmploye(ListUsers.idE);
    });
  
  } 

  

  void decodePwdM(String password){
          print("sietradecode");
          var decoded_bytes = base64.decode(password);
          var decoded_str = utf8.decode(decoded_bytes);
          decodePwd=decoded_str.toString(); 
          print(decodePwd);         
  }

   @override
  void initState() {
     //users = this.fetchUsers();
     print("######initstate");
     if (int.parse(ListUsers.idE)!=0) {
       print("##########getWorkArea");
          this.getWorkArea();
     }
    }


  var urlPost = Uri.parse('https://yoenvio.synology.me/ITI1005/employe/?post');
  var urlUpdate = Uri.parse('https://yoenvio.synology.me/ITI1005/employe/?update');

  Future<void> postData(BuildContext context) async {
    if (controllerNoEmple.text.isNotEmpty) {
      if (controllerNombre.text.isNotEmpty) {
          if (controllerTelefono.text.isNotEmpty) {
              if (controllerRFC.text.isNotEmpty) {
                  if (controllerDireccion.text.isNotEmpty) {
                      if (controllerNSS.text.isNotEmpty) {
                        if (valorSexo!=0) {
                            if (areaDT!='') {
                              if (birthday!='') {
                                if (dateStr != 'Fecha de admisión') {
                                    final response = await http.post(urlPost, body: {
                                    "user": controllerUser.text,
                                    "password": decodePwd,
                                    "noEmploye": controllerNoEmple.text,
                                    "name": controllerNombre.text,
                                    "rol": valorAreaT.toString(),
                                    "phone": controllerTelefono.text,
                                    "rfc": controllerRFC.text,
                                    "address": controllerDireccion.text,
                                    "nss": controllerNSS.text,
                                    "sex": valorSexo.toString(),
                                    "workArea": areaDT,
                                    "birthday": birthday,
                                    "dateAdmission": dateStr,
                                    });

                                    var body = json.decode(response.body);
                                  // print(jsonResponse.containsKey("key"););
                                  if(body.containsKey("success")){
                                    //snackbarM("Success");
                                    _navigateToNextScreen(context);
                                  }
                                }else{
                                  snackbarM("Agrega una fecha de admisión");
                                }
                              }else{
                                snackbarM("Agrega la fecha de nacimiento del usuario");
                              }
                            }else{
                              snackbarM("Selecciona una área de trabajo");
                            }
                        }else{
                          snackbarM("Campo de sexo vacio");
                        }
                      }else{
                        snackbarM("Campo de número de seguro social vacio");
                      }
                  }else{
                    snackbarM("Campo de dirección vacio");
                  }
              }else{
                snackbarM("Campo de RFC vacio");
              }
          }else{
            snackbarM("Campo de teléfono vacio");
          }
      }else{
        snackbarM("Campo de número de empleado vacio");
      }
    }else{
      snackbarM("Campo de usuario vacio");
    }
    
      
    }

  Future<void> updateData(BuildContext context) async {
    if (controllerNoEmple.text.isNotEmpty) {
      if (controllerNombre.text.isNotEmpty) {
          if (controllerTelefono.text.isNotEmpty) {
              if (controllerRFC.text.isNotEmpty) {
                  if (controllerDireccion.text.isNotEmpty) {
                      if (controllerNSS.text.isNotEmpty) {
                        if (valorSexo!=0) {
                            if (areaDT!='') {
                              if (birthday!='') {
                                if (dateStr != 'Fecha de admisión') {
                                    final response = await http.post(urlUpdate, body: {
                                    "user": controllerUser.text,
                                    "password": decodePwd,
                                    "noEmploye": controllerNoEmple.text,
                                    "name": controllerNombre.text,
                                    "rol": valorAreaT.toString(),
                                    "phone": controllerTelefono.text,
                                    "rfc": controllerRFC.text,
                                    "address": controllerDireccion.text,
                                    "nss": controllerNSS.text,
                                    "sex": valorSexo.toString(),
                                    "workArea": areaDT,
                                    "birthday": birthday,
                                    "dateAdmission": dateStr,
                                    "id": ListUsers.idE,
                                    });

                                    var body = json.decode(response.body);
                                  // print(jsonResponse.containsKey("key"););
                                  if(body.containsKey("success")){
                                    //snackbarM("Success");
                                    _navigateToNextScreen(context);
                                  }
                                }else{
                                  snackbarM("Agrega una fecha de admisión");
                                }
                              }else{
                                snackbarM("Agrega la fecha de nacimiento del usuario");
                              }
                            }else{
                              snackbarM("Selecciona una área de trabajo");
                            }
                        }else{
                          snackbarM("Campo de sexo vacio");
                        }
                      }else{
                        snackbarM("Campo de número de seguro social vacio");
                      }
                  }else{
                    snackbarM("Campo de dirección vacio");
                  }
              }else{
                snackbarM("Campo de RFC vacio");
              }
          }else{
            snackbarM("Campo de teléfono vacio");
          }
      }else{
        snackbarM("Campo de nombre vacio");
      }
    }else{
      snackbarM("Campo de número de empleado vacio");
    }
    
      
    }

    void snackbarM (String text) {
   final snackBar = SnackBar(content: Text(text));
   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

     void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListUsers()));
  }


  changeDate(String date) {
    setState(() {
     dateStr = date; 
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final btnLimpiar = ElevatedButton.styleFrom(
        primary: Colors.lightBlue,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    final btnSig = ElevatedButton.styleFrom(
        primary: Colors.lightBlue,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Agregar colaborador', style: TextStyle(color: Colors.white)),
      )),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: Text('No. Empleado:'),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: controllerNoEmple,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: '',),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('Nombre:'),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: controllerNombre,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: ''),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('Teléfono:'),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: controllerTelefono,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: ''),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('RFC:'),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: controllerRFC,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(hintText: ''),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('Dirección:'),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: controllerDireccion,
                  decoration: InputDecoration(hintText: ''),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('NSS:'),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: controllerNSS,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: ''),
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
                title: Center(
                  child: Text(
                    "Sexo",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text("Masculino"),
                  leading: Radio(
                    value: 1,
                    groupValue: valorSexo,
                    onChanged: (value) {
                      setState(() {
                        valorSexo = int.parse(value.toString());
                      });
                    },
                    activeColor: Colors.black,
                  ),
                ),
                ListTile(
                  title: Text("Femenino"),
                  leading: Radio(
                      value: 2,
                      groupValue: valorSexo,
                      onChanged: (value) {
                        setState(() {
                          valorSexo = int.parse(value.toString());
                        });
                      },
                      activeColor: Colors.black),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('Área de Trabajo:'),
              ),
              Container(
                width: 250,
                child: DropdownButton(
                    value: areaT,
                    items: [
                      DropdownMenuItem(
                        child: Text("Selecciona el área"),
                        value: 0,
                      ),
                      DropdownMenuItem(child: Text("Recursos Humanos"), value: 1),
                      DropdownMenuItem(child: Text("Sistemas"), value: 2),
                      DropdownMenuItem(child: Text("Limpieza"), value: 3),
                      DropdownMenuItem(child: Text("Contabilidad"), value: 4),
                      DropdownMenuItem(child: Text("Cobranza"), value: 5),
                    ],
                    onChanged: (value) {
                      setState(() {
                        areaT = int.parse(value.toString());
                        valorAreaT = int.parse(value.toString()) - 1;
                        print(areaT.toString());
                        areaDT = AreaSeleccionada(valorAreaT);
                      });
                    }),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: ListTile(
              title: Text(
                "Fecha de nacimiento",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: ListTile(
                  title: Text(
                    "Día",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                width: 100,
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: ListTile(
                  title: Text(
                    "Mes",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                width: 100,
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: ListTile(
                  title: Text(
                    "Año",
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextField(
                  controller: controllerDia,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Dia'),
                ),
              ),
              Container(
                width: 100,
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextField(
                  controller: controllerMes,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Mes'),
                ),
              ),
              Container(
                width: 100,
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextField(
                  controller: controllerAnio,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Año'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('$dateStr',style: TextStyle(color: Colors.grey,fontSize: 16)),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                        child: Text('Seleccionar Fecha'),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050))
                              .then((fechaSelecc) {
                            setState(() {
                              fechaIngreso = fechaSelecc!;
                              print(fechaIngreso.toString().substring(0, 10 )+"######");
                              changeDate(fechaIngreso.toString().substring(0, 10 ));
                            });
                          });
                        }),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('Usuario:'),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: controllerUser,
                  decoration: InputDecoration(hintText: ''),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: Text('Contraseña:'),
              ),
              Container(
                width: 250,
                child: TextField(
                  obscureText: true,
                  controller: controllerPassword,
                  decoration: InputDecoration(hintText: ''),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (valorSexo == 1) {
                        sexo = 'Masculino';
                      } else if (valorSexo == 2) {
                        sexo = 'Femenino';
                      }
                      //String fechaIngresoFin =
                          //DateFormat('yyyy-MM-dd – kk:mm').format(fechaIngreso);
                      NoEmpleado = controllerNoEmple.text;
                      Nombre = controllerNombre.text;
                      Telefono = controllerTelefono.text;
                      RFC = controllerRFC.text;
                      Direccion = controllerDireccion.text;
                      NSS = controllerNSS.text;
                      Anio = controllerAnio.text;
                      Dia = controllerDia.text;
                      Mes = controllerMes.text;
                     print('Tu numero de empleado es: '+controllerNoEmple.text+'\n Tu nombre es: $Nombre\n Tu telefono es: $Telefono\n Tu RFC es: $RFC\n Tu direccion es: $Direccion\n Tu NSS es: $NSS\n Tu Sexo es: $sexo\n Tu Area de trabajo es: $areaDT\n Tu fecha de naciemiento es: $Dia/$Mes/$Anio\n Ingresaste el dia:$dateStr');
                     birthday='$Anio-$Mes-$Dia';
                     if(controllerPassword.text.isNotEmpty){
                          var bytes = utf8.encode(controllerPassword.text);
                          var base64Str = base64.encode(bytes);
                          print(base64Str.toString());
                          decodePwd=base64Str.toString();
                        }
                     print(birthday+"####################");
                     print(ListUsers.idE+"####################");
                     if (int.parse(ListUsers.idE)==0) {
                       print("post");
                       postData(context);
                     }else{
                        updateData(context);
                        print("update");
                     }
                     
                    },
                    style: btnSig,
                    child: Text(
                      'Guardar',
                      style: TextStyle(fontSize: 20.0),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  AreaSeleccionada(int value) {
    if (value == 0) {
      areaDT = 'Recursos Humanos';
      return areaDT;
    } else if (value == 1) {
      areaDT = 'Sistemas';
      return areaDT;
    } else if (value == 2) {
      areaDT = 'Limpieza';
      return areaDT;
    } else if (value == 3) {
      areaDT = 'Contabilidad';
      return areaDT;
    } else if (value == 4) {
      areaDT = 'Cobranza';
      return areaDT;
    }
  }
}
