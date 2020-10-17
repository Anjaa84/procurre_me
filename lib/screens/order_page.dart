import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/item.dart';
import 'package:flutter_project/model/orders.dart';
import 'package:flutter_project/model/supplier.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/screens/single_order_page.dart';
import 'package:flutter_project/utils/database_helper.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Item _item = Item();
  User _user = User();
  Orders _order=Orders();
  User _currentUser;
  Supplier _currentSupplier;
  List<Item> _items = [];
  List<Orders> _orders = [];


  DatabaseHelper _dbHelper;
  String _currentItem;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  final _formKey = GlobalKey<FormState>();
  final _ctrlQuantity = TextEditingController();
  final _ctrlSiteLocation=TextEditingController();
  final _ctrlSupplierName = TextEditingController();
  final _ctrlSupplier = TextEditingController();
  final _ctrlSupplierPrice = TextEditingController();
  final _ctrlDate = TextEditingController();
  String _myActivity;
  String _myActivityResult;


  _showForEdit(index) {
    setState(() {
      _item = _items[index];

    });
  }


  _onSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_order.orderId == null)
        await _dbHelper.insertOrder(_order);
      // else
      //   await _dbHelper.updateItem(_supplier);

       form.reset();
      await _refreshOrderList();
      _resetForm();
    }
  }

  _refreshOrderList() async {
    List<Orders> x = await _dbHelper.fetchOrders();
    setState(() {
      _orders = x;
    });
  }

   _resetForm() {
     setState(() {
       _formKey.currentState.reset();
       _ctrlSiteLocation.clear();
       _ctrlSupplierName.clear();
       _ctrlSupplierPrice.clear();
       _ctrlDate.clear();

       _order.orderId = null;
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleOrderPage(index:index,orderItem: _orders[index],)));

                  },
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Text(
                        'Id: ${_orders[index].orderId}',
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
                    _orders[index].sLocation.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),


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
          itemCount: _orders.length,
        ),
      ),
    ),
  );



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

  String dropDownValue = 'Account Manager';// string to  store the  drop down initial value



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

          TextFormField(
            controller: _ctrlSiteLocation,
            decoration: InputDecoration(labelText: 'Site Location'),
            validator: (val) =>
            (val.length == 0 ? 'This field is mandatory' : null),
            onSaved: (val) => setState(() => _order.sLocation = val),
          ),
          FutureBuilder<List<User>>(
              future: _dbHelper.getUserModelData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<User>> snapshot) {
                String dropDownValue =snapshot.data[0].role;

                if (!snapshot.hasData) return CircularProgressIndicator();
                return DropdownButton<User>(

                  items: snapshot.data
                      .map((user) => DropdownMenuItem<User>(
                    child: Text(user.role),
                    value: user,
                  ))
                      .toList(),
                  onChanged: (User value) {
                    setState(() {
                      _currentUser = value;
                    });
                  },
                  isExpanded: false,
                  //value: _currentUser,
                  hint: Text('Select User'),

                );
              }),

          TextFormField(
            controller: _ctrlSupplierName,

            decoration: InputDecoration(labelText: 'Item Name'),
            validator: (val) =>
            (val.length == 0 ? 'This field is mandatory' : null),
            onSaved: (val) => setState(() => _order.itemName = val),
          ),

          FutureBuilder<List<Supplier>>(
              future: _dbHelper.getSupplierModelData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Supplier>> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return DropdownButton<Supplier>(
                  items: snapshot.data
                      .map((supplier) => DropdownMenuItem<Supplier>(
                    child: Text(supplier.companyName),
                    value: supplier,
                  ))
                      .toList(),
                  onChanged: (Supplier value) {
                    setState(() {
                      _currentSupplier = value;
                    });
                  },
                  isExpanded: false,
                  //value: _currentUser,
                  hint: Text('Select Supplier'),

                );
              }),

                TextFormField(
                  controller: _ctrlSupplierPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (val) =>
                  (val.length == 0 ? 'This field is mandatory' : null),
                  onSaved: (val) => setState(() => _order.price = int.parse(val)),
                ),

                TextFormField(
                  controller: _ctrlDate,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Date'),
                  validator: (val) =>
                  (val.length == 0 ? 'This field is mandatory' : null),
                  onSaved: (val) => setState(() => _order.date = val),
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
           _form(),_list()

           ],
         )
      ),
    );
  }
}
