import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Dataclass.dart';

class SearchItem extends StatelessWidget {
  PredictionResult item;

  SearchItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 16,left: 20),
        height: 66,
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on,color: Colors.black38,),
            SizedBox(width: 20,),
            Expanded(child: Text(item.name,maxLines: 2,style: TextStyle(color: Colors.black87),)),
          ],
        ));
  }
}
