import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/small_ui_components/OrdersCard.dart';
import 'package:provider/provider.dart';

class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  FirebaseProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<FirebaseProvider>(context);
    if (!provider.orderIsEmpty) {
      return FutureBuilder(
          future: provider.fireRetrieveOrders(),
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    OrderData v = snap.data[index];
                    return OrdersCard(
                      orderDate: v.orderDate,
                      orderId: v.orderId,
                      location: v.formattedAddress,
                      status: v.status,
                      quantity: v.quantity,
                    );
                  });
            } else {
              return LinearProgressIndicator();
            }
          });
    } else {
      return FutureBuilder(future:provider.fireRetrieveOrders(),builder:(context,snap){
        return Container(alignment:Alignment.center,child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: <Widget>[
          Container(child: Image.asset("assets/NoOrders.png",),height: 200,width: 200,),
          Text("No Orders Found")
        ],),);});
    }
  }

}
