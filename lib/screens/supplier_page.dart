import 'package:flutter/material.dart';
import 'package:flutter_project/model/supplier.dart';
import 'package:flutter_project/utils/database_helper.dart';

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPageState createState() => _SupplierPageState();
}


class _SupplierPageState extends State<SupplierPage> {
  Supplier _supplier=Supplier();
  final _formKey = GlobalKey<FormState>();
  final _ctrlSupplier = TextEditingController();
  DatabaseHelper _dbHelper;

  @override
  void initState() {

    super.initState();
    _dbHelper = DatabaseHelper.instance;

  }



  _onSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_supplier.supplierId == null)
        await _dbHelper.insertSupplier(_supplier);
      // else
      //   await _dbHelper.updateItem(_supplier);
      // _resetForm();
      // form.reset();
      // await _refreshItemList();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlSupplier.clear();

    });
  }


  _form() => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[


          TextFormField(
            controller: _ctrlSupplier,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Supplier Name'),
            validator: (val) =>
            (val.length == 0 ? 'This field is mandatory' : null),
            onSaved: (val) => setState(() => _supplier.companyName = val),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        title: Text('Supplier'),
      ),
      body: Center(
          child:

          Column(
            children: [
              _form(),

            ],
          )
      ),
    );
  }
}
