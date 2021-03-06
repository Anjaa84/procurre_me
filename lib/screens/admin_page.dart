import 'package:flutter/material.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/utils/database_helper.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class FirstNameValidation{
  static String validate(String value){
    return value.isEmpty ? 'First Name cannot be null':null;
  }
}

class LastNameValidation{
  static String validate(String value){
    return value.isEmpty ? 'Last Name  cannot be null':null;
  }
}


class EmailValidation{
  static String validate(String value){
    return value.isEmpty ? 'Email cannot be null':null;
  }
}

class PasswordValidation{
  static String validate(String value){
    return value.isEmpty ? 'Passoword cannot be null':null;
  }
}

class _AdminPageState extends State<AdminPage> {
  User _user=User();

  List<User> _users =[];

  final _formKey = GlobalKey<FormState>();
  DatabaseHelper _dbHelper;

  final _ctrlFirstName = TextEditingController();
  final _ctrlLastName = TextEditingController();
  final _ctrlEmail = TextEditingController();
  final _ctrlPassword = TextEditingController();


String dropdownValue='Account Manager';
  _dropDown(){

    return DropdownButton(
      value:dropdownValue,
      items: <String>[ 'Account Manager', 'Supervisor', 'Site Manager'].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (val) {
        setState(() => { _user.role = val ,dropdownValue=val }

        );

      },
    );
  }


  _form() => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _dropDown(),
          TextFormField(
            controller:_ctrlFirstName ,
            decoration: InputDecoration(labelText: 'First Name'),
            validator: FirstNameValidation.validate,
            onSaved: (val) =>  setState(() => _user.firstname=val),),
          TextFormField(
            controller: _ctrlLastName,
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: LastNameValidation.validate,
            onSaved: (val) => setState(() => _user.lastname = val),
          ),
          TextFormField(
            controller: _ctrlEmail,

            decoration: InputDecoration(labelText: 'Email'),
            validator: EmailValidation.validate,
            onSaved: (val) => setState(() => _user.email = val),
          ),
          TextFormField(
            controller: _ctrlPassword,

            decoration: InputDecoration(labelText: 'Password'),
            validator: PasswordValidation.validate,
            onSaved: (val) => setState(() => _user.password = val),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () => _onSubmit(),
              child: Text('Submit'),
              color: Colors.deepPurpleAccent,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      if (_user.userId == null) {

        await _dbHelper.insertUser(_user);

      }else{
      }
//      else
//        await _dbHelper.updateItem(_item);
      form.reset();
      await _updateUsers();
      _resetForm();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlFirstName.clear();
      _ctrlLastName.clear();
      _ctrlEmail.clear();
      _ctrlPassword.clear();
     _user.userId= null;
    });
  }


  _list() => Expanded(
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Icon(
                        Icons.person,
                        color: Colors.deepPurpleAccent,
                        size: 20.0,
                      ),
                    ],
                  ),
                  title: Text(
                    _users[index].role.toUpperCase(),
                    style: TextStyle(
                        color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_users[index].firstname),
                      Text(_users[index].lastname),
                    ],
                  ),
                  onTap: () {
//                    _showForEdit(index);
                  },
//                  trailing: IconButton(
////                      icon: Icon(Icons.delete_sweep, color: darkBlueColor),
//                      onPressed: () async {
////                        await _dbHelper.deleteItem(_items[index].itemId);
////                        _resetForm();
//                        _updateUsers();
//                      }),
                ),
                Divider(
                  height: 5.0,
                ),
              ],
            );
          },
          itemCount: _users.length,
        ),
      ),
    ),
  );

  _updateUsers() async{
    List<User> userList = await _dbHelper.fetchUsers();
    setState(() {
      _users = userList;
    });

  }
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _updateUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Admin'),
        centerTitle: true,
      ),



      body: Container(
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(),_list()],
        ),
      )

      ),

    );
  }
}
