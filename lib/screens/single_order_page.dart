import 'package:flutter/material.dart';
import 'package:flutter_project/model/orders.dart';
// child: Text('${orderItem.orderId}'),
class SingleOrderPage extends StatelessWidget {
final int index;
final Orders orderItem;
   SingleOrderPage({Key key, this.index,this.orderItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                             '${orderItem.orderId}',
                            ),
                            Icon(
                              Icons.build,
                              color: Colors.deepPurpleAccent,
                              size: 20.0,
                            ),
                          ],
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

              ),
            ),
          ),

    );
  }
}
