class Users {
  String id="";
  String user="";
  String password="";
  String status="";
  String noEmploye="";
  String name="";
  String phone="";
  String rfc="";
  String address="";
  String nss="";
  String sex="";
  String workArea="";
  String birthday="";
  String dateAdmission="";
 

  Users();

  getId(){
    return this.id;
  }

  getUser(){
    return this.user;
  }

  getPassword(){
    return this.password;
  }

  getStatus(){
    return this.status;
  }

  getEmploye(){
    return this.noEmploye;
  }

  getName(){
    return this.name;
  }

  getPhone(){
    return this.phone;
  }

  getRfc(){
    return this.rfc;
  }

  getAddress(){
    return this.address;
  }

  getNss(){
    return this.nss;
  }

  getSex(){
    return this.sex;
  }

  getWorkArea(){
    return this.workArea;
  }

  getBirthday(){
    return this.birthday;
  }

  getDateAdmission(){
    return this.dateAdmission;
  }

  factory Users.fromJson(Map<String, dynamic> json){
    Users u = new Users();
    u.id = json["id"];
    u.user = json["user"];
    u.password = json["password"];
    u.status = json["status"];
    u.noEmploye = json["profile"]["noEmploye"];
    u.name = json["profile"]["name"];
    u.phone = json["profile"]["phone"];
    u.rfc = json["profile"]["rfc"];
    u.address = json["profile"]["address"];
    u.nss = json["profile"]["nss"];
    u.sex = json["profile"]["sex"];
    u.workArea = json["profile"]["workArea"];
    u.birthday = json["profile"]["birthday"];
    u.dateAdmission = json["profile"]["dateAdmission"];
    return u;

  }
  
}