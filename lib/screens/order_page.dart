import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/item.dart';
import 'package:flutter_project/utils/database_helper.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Item _item = Item();
  List<Item> _items = [];
  DatabaseHelper _dbHelper;
  String _currentItem;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  final _formKey = GlobalKey<FormState>();
  final _ctrlQuantity = TextEditingController();
  final _ctrlSupplierName = TextEditingController();
  String _myActivity;
    String _myActivityResult;



  _refreshItemList() async {
    List<Item> x = await _dbHelper.fetchItems();
    setState(() {
      _items = x;
    });
  }

  _saveForm() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _refreshItemList();
//    _dropDownMenuItems=getDropDownMenuItems();
//    _currentItem = _items[0].itemName;

  }
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (Item item in _items) {
      items.add(new DropdownMenuItem(
          value: Item.colName,
          child: new Text(Item.colName)
      ));
    }
    return items;
  }
  _form() => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[

          DropDownFormField(
            titleText: 'Select Item',
            hintText: 'Please choose one',
            value: _myActivity,
            onSaved: (value) {
              setState(() {
                _myActivity = value;
              });
            },
            onChanged: (value) {
              setState(() {
                _myActivity = value;
              });
            },
            dataSource: [
              {
                "display": "Cement",
                "value": "Cement",
              },
              {
                "display": "Paint",
                "value": "Paint",
              },
              {
                "display": "Sand",
                "value": "Sand",
              },

            ],
            textField: 'display',
            valueField: 'value',
          ),

          TextFormField(
            controller: _ctrlQuantity,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Quantity'),
            validator: (val) =>
            (val.length == 0 ? 'This field is mandatory' : null),
            onSaved: (val) => setState(() => _item.itemPrice = val),
          ),
          TextFormField(
            controller: _ctrlSupplierName,
            decoration: InputDecoration(labelText: 'Supplier Name'),
            validator: (val) =>
            (val.length == 0 ? 'This field is mandatory' : null),
            onSaved: (val) => setState(() => _item.itemBrand = val),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () => _saveForm(),
              child: Text('Submit'),
              color: Colors.deepPurpleAccent,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );


  void changedDropDownItem(String selectedItem) {
    setState(() {
      _currentItem = selectedItem;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        title: Text('Order'),
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
