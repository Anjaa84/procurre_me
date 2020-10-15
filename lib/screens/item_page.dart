import 'package:flutter/material.dart';
import 'package:flutter_project/model/item.dart';
import 'package:flutter_project/screens/order_page.dart';
import 'package:flutter_project/screens/supplier_page.dart';
import 'package:flutter_project/utils/database_helper.dart';

import '../main.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Item _item = Item();
  List<Item> _items = [];
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper _dbHelper;
  final _ctrlName = TextEditingController();
  final _ctrlBrand = TextEditingController();
  final _ctrlPrice = TextEditingController();

  _form() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ctrlName,
                decoration: InputDecoration(labelText: 'Item Name'),
                validator: (val) =>
                    (val.length == 0 ? 'This field is mandatory' : null),
                onSaved: (val) => setState(() => _item.itemName = val),
              ),
              TextFormField(
                controller: _ctrlBrand,
                decoration: InputDecoration(labelText: 'Brand'),
                validator: (val) =>
                    (val.length == 0 ? 'This field is mandatory' : null),
                onSaved: (val) => setState(() => _item.itemBrand = val),
              ),
              TextFormField(
                controller: _ctrlPrice,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (val) =>
                    (val.length == 0 ? 'This field is mandatory' : null),
                onSaved: (val) => setState(() => _item.itemPrice = val),
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
      if (_item.itemId == null)
        await _dbHelper.insertItems(_item);
      else
        await _dbHelper.updateItem(_item);
      _resetForm();
      form.reset();
      await _refreshItemList();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlName.clear();
      _ctrlBrand.clear();
      _ctrlPrice.clear();
      _item.itemId = null;
    });
  }

  _showForEdit(index) {
    setState(() {
      _item = _items[index];
      _ctrlName.text = _items[index].itemName;
      _ctrlBrand.text = _items[index].itemBrand;
      _ctrlPrice.text = _items[index].itemPrice;
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
                          Text(
                            'Id: ${_items[index].itemId}',
                            style: TextStyle(fontSize: 10),
                          ),
                          Icon(
                            Icons.shop_outlined,
                            color: Colors.deepPurpleAccent,
                            size: 20.0,
                          ),
                        ],
                      ),
                      title: Text(
                        _items[index].itemName.toUpperCase(),
                        style: TextStyle(
                            color: darkBlueColor, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_items[index].itemBrand),
                          Text(_items[index].itemPrice),
                        ],
                      ),
                      onTap: () {
                        _showForEdit(index);
                      },
                      trailing: IconButton(
                          icon: Icon(Icons.delete_sweep, color: darkBlueColor),
                          onPressed: () async {
                            await _dbHelper.deleteItem(_items[index].itemId);
                            _resetForm();
                            _refreshItemList();
                          }),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                  ],
                );
              },
              itemCount: _items.length,
            ),
          ),
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshItemList();
  }

  _refreshItemList() async {
    List<Item> x = await _dbHelper.fetchItems();
    setState(() {
      _items = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Items',
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>OrderPage() ));
        },
      ),
    );
  }
}
