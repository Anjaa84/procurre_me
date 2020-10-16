import 'package:flutter/material.dart';
import 'package:flutter_project/model/contact.dart';
import 'package:flutter_project/screens/admin_page.dart';
import 'package:flutter_project/screens/home_page.dart';
import 'package:flutter_project/screens/item_page.dart';
import 'package:flutter_project/utils/database_helper.dart';

void main() {
  runApp(MyApp());
}

const darkBlueColor = Color(0xff486579);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primaryColor: darkBlueColor,
      ),
      home: AdminPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Contact _contact = Contact();
  List<Contact> _contacts = [];
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper _dbHelper;

  final _ctrlName = TextEditingController();
  final _ctrlMobile = TextEditingController();

  _form() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ctrlName,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (val) =>
                    (val.length == 0 ? 'This field is mandatory' : null),
                onSaved: (val) => setState(() => _contact.name = val),
              ),
              TextFormField(
                controller: _ctrlMobile,
                decoration: InputDecoration(labelText: 'Mobile'),
                validator: (val) =>
                    val.length < 10 ? '10 characters required' : null,
                onSaved: (val) => setState(() => _contact.mobile = val),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () => _onSubmit(),
                  child: Text('Submit'),
                  color: darkBlueColor,
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
      if (_contact.id == null)
        await _dbHelper.insertContact(_contact);
      else
        await _dbHelper.updateContact(_contact);
      _resetForm();
      form.reset();
      await _refreshContactList();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlName.clear();
      _ctrlMobile.clear();
      _contact.id = null;
    });
  }

  _list() => Expanded(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: darkBlueColor,
                        size: 40.0,
                      ),
                      title: Text(
                        _contacts[index].name.toUpperCase(),
                        style: TextStyle(
                            color: darkBlueColor, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_contacts[index].mobile),
                      onTap: () {
                        _showForEdit(index);
                      },
                      trailing: IconButton(
                          icon: Icon(Icons.delete_sweep, color: darkBlueColor),
                          onPressed: () async {
                            await _dbHelper.deleteContact(_contacts[index].id);
                            _resetForm();
                            _refreshContactList();
                          }),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                  ],
                );
              },
              itemCount: _contacts.length,
            ),
          ),
        ),
      );

  _showForEdit(index) {
    setState(() {
      _contact = _contacts[index];
      _ctrlName.text = _contacts[index].name;
      _ctrlMobile.text = _contacts[index].mobile;
    });
  }

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshContactList();
  }

  _refreshContactList() async {
    List<Contact> x = await _dbHelper.fetchContacts();
    setState(() {
      _contacts = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Procure',
            style: TextStyle(color: darkBlueColor),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(), _list()],
        ),
      ),
    );
  }
}
