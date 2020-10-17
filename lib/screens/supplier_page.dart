import 'package:flutter/material.dart';
import 'package:flutter_project/model/supplier.dart';
import 'package:flutter_project/utils/database_helper.dart';

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPageState createState() => _SupplierPageState();
}


class _SupplierPageState extends State<SupplierPage> {
  Supplier _supplier=Supplier();
  List<Supplier> _supplier1 = [];
  final _formKey = GlobalKey<FormState>();
  final _ctrlSupplier = TextEditingController();
  DatabaseHelper _dbHelper;



  _refreshOrderList() async {
    List<Supplier> x = await _dbHelper.fetchSupplier();
    setState(() {
      _supplier1 = x;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _refreshItemList();
//    _dropDownMenuItems=getDropDownMenuItems();
//    _currentItem = _items[0].itemName;
    _dbHelper = DatabaseHelper.instance;
    _refreshOrderList();
  }



  _onSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_supplier.supplierId == null)
        await _dbHelper.insertSupplier(_supplier);
      // else
      //   await _dbHelper.updateItem(_supplier);
       form.reset();
       await _refreshOrderList();
      _resetForm();

    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlSupplier.clear();

    });
  }

  _list() =>
      Expanded(
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

                          Text(
                            'Id: ${_supplier1[index].supplierId}',
                            style: TextStyle(fontSize: 10),
                          ),
                          Icon(
                            Icons.build,
                            color: Colors.deepPurpleAccent,
                            size: 20.0,
                          ),
                        ],
                      ),
                      title: Text(
                        _supplier1[index].companyName.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),

                      // onTap: () {
                      //   _showForEdit(index);
                      // },
                      // trailing: IconButton(
                      //     icon: Icon(Icons.delete_sweep, color: Colors.black),
                      //     onPressed: () async {
                      //       await _dbHelper.deleteItem(_items[index].itemId);
                      //       // _resetForm();
                      //       _refreshOrderList();
                      //     }),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                  ],
                );
              },
              itemCount: _supplier1.length,
            ),
          ),
        ),
      );



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
              _form(),_list()

            ],
          )
      ),
    );
  }
}
