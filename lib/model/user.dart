class User {
  static const tblUser = 'users';
  static const colId = 'userId';
  static const colRole = 'role';
  static const colFirstname = 'firstname';
  static const colLastname = 'lastname';
  static const colPassword = 'password';
  static const colEmail = 'email';
  int userId;
  String role;
  String firstname;
  String lastname;
  String password;
  String email;

  User({this.userId,this.role,this.firstname,this.lastname, this.password, this.email});


  User.fromMap (Map map){
    userId = map[colId];
    role = map[colRole];
    firstname = map[colFirstname];
    lastname = map[colLastname];
    password = map[colPassword];
    email = map[colEmail];

  }

  toMap(){
    var map =<String,dynamic> {colRole:role,colFirstname:firstname,colLastname:lastname,colEmail:email,colPassword:password};
    if(userId != null){
      map[colId]=userId;
    }
    return map;
  }












}
