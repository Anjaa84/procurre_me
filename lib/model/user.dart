class User {
  static const tblUser = 'users';
  static const colId = 'userId';
  static const colRole = 'role';
  static const colFirstname = 'firstname';
  static const colLastname = 'lastname';
  static const colPassword = 'password';
  static const colEmail = 'email';


  User({this.id,this.role,this.firstname,this.lastname, this.password, this.email});
  int id;
  String role;
  String firstname;
  String lastname;
  String password;
  String email;

  User.fromMap (Map map){
    id = map[colId];
    role = map[colRole];
    firstname = map[colFirstname];
    lastname = map[colLastname];
    password = map[colPassword];
    email = map[colEmail];

  }

  toMap(){
    var map =<String,dynamic> {colRole:role,colFirstname:firstname,colLastname:lastname,colEmail:email,colPassword:password};
    if(id != null){
      map[colId]=id;
    }
    return map;
  }












}
