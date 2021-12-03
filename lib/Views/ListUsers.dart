import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:project_final/Model/Users.dart';
import 'package:project_final/Views/ViewUser.dart';


class ListUsers extends StatefulWidget {
  static String idE = "5";
  ListUsers({Key? key}) : super(key: key); 

  String _server='';

  ServerInfo(String server) {
    this._server = server;
    print(_server);
  }



  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
 // List<Users> data=List<Users>();
  // List data=[];
  List<Users> users=[];
  var url = Uri.parse('https://yoenvio.synology.me/ITI1005/employe/?delete');

  Widget appBarTitle = new Text(
    "Search Example",
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<Users> searchresult = [];
  bool _isSearching=false;
  String _searchText = "";

  _SearchListExampleState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }


  Future<String> getData() async {
    var response = await http.get(
      Uri.parse("https://yoenvio.synology.me/ITI1005/employe/?get&all"),
      headers: {
        "Accept": "application/json"
      }
    );
    this.setState((){
        //users = this.userList(json.decode(response.body)["data"]);
        users = this.usersList(response.body);
    });
  
    
    return "Success!";
  } 

  Future<void> delete(BuildContext context, String id) async {
      final response = await http.post(url, body: {
      "id": id,
      });

      var body = json.decode(response.body);

     if(body.containsKey("success")){
       this.getData();
     }
      
    }


  
  
  
  
  
  
  List<Users> usersList(String responseBody) { 
   final parsed = json.decode(responseBody)["data"].cast<Map<String, dynamic>>(); 
   return parsed.map<Users>((json) =>Users.fromJson(json)).toList(); 
} 

  @override
  void initState() {
     //users = this.fetchUsers();
     this.getData();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:new ListView.builder(
        itemCount: users==null?0:users.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
          child:Container(
            height: 170,
            color: Colors.white,
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Expanded(
                      child:Image.asset("assets/img/ic_user.jpg"),
                      flex:2 ,
                    ),
                  ),
                ),
                Expanded(
                  child:Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          //child: ListTile(
                            //title: Text(users[index].getName()),
                            //subtitle: Text(users[index].getPhone()),
                          //),
                          child: Column(
                            children: [
                              Row(
                              children:<Widget>[
                                Padding(
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  top: 10,
                                  right: 10,
                                  bottom: 0,
                                ),
                                child: Text("Id:",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Text(users[index].getId())
                                ]
                              ),
                              Row(
                              children:<Widget>[
                                Padding(
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  top: 0,
                                  right: 10,
                                  bottom: 0,
                                ),
                                child: Text("No Empleado:",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Text(users[index].getEmploye())
                                ]
                              ),
                              Row(
                              children:<Widget>[
                                Padding(
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  top: 0,
                                  right: 10,
                                  bottom: 0,
                                ),
                                child: Text("Nombre:",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Text(users[index].getName())
                                ]
                              ),
                              Row(
                              children:<Widget>[
                                Padding(
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  top: 0,
                                  right: 10,
                                  bottom: 0,
                                ),
                                child: Text("Área de trabajo:",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Text(users[index].getWorkArea())
                                ]
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child:Text("Editar"),
                                onPressed: ()
                                {
                                  print("click"+index.toString());
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewUser()));
                                  ViewUser.sendData(users[index].getId());
                                // widget._server=users[index].getId();
                                // print(idE+"#############server");

                                },
                              ),
                              SizedBox(width: 8,),
                              TextButton(
                                child: Text("Eliminar",style: TextStyle(color: Colors.red)),
                                onPressed: (){
                                   _showMyDialog(users[index].getId());
                                },
                              ),
                              SizedBox(width: 8,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          elevation: 8,
          margin: EdgeInsets.all(10),
        );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewUser()));
        },
        child: const Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.blue,
      ),
      
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < users.length; i++) {
        if (users[i].getName().toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(users[i]);
        }
      }
    }
  }




  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('¿Estas seguro que deseas eliminar a este usuario del sistema?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                delete(context,id);
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}