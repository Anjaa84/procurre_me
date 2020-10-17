import 'package:flutter/material.dart';
import 'package:flutter_project/model/orders.dart';
import 'package:flutter_project/utils/database_helper.dart';

class SupervisorPage extends StatefulWidget {
  @override
  _SupervisorPageState createState() => _SupervisorPageState();
}

class _SupervisorPageState extends State<SupervisorPage> {
  Orders _order = Orders();
  List<Orders> _orders = [];

  DatabaseHelper _dbHelper;

  _refreshOrderList() async {
    List<Orders> x = await _dbHelper.getOrdersPrice();
    setState(() {
      _orders = x;
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

  _dropDown(int index) {
    return DropdownButton<String>(
      items: <String>['Pending', 'Approved'].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (val) {
        setState(() => _order.status = val);
        _dbHelper.insertOrderStatus(_order.status, index);
      },
    );
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
                      title: Column(
                        children: [
                          Text(
                            _orders[index].sLocation.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),

                      // onTap: () {
                      //   _showForEdit(index);
                      // },
                      trailing: _dropDown(_orders[index].orderId),
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Supervisor'),
      ),
      body: Center(
          child: Column(
        children: [_list()],
      )),
    );
  }
}
