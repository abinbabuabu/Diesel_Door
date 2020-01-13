import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Ui_Pages/DetailsPage.dart';
import 'package:petrol_pump/small_ui_components/RouteAnimations.dart';

class UILoading extends StatelessWidget{
  static const routeName = '/loading';
  @override
  Widget build(BuildContext context) {
   Future.delayed(Duration(seconds: 1),(){
     Navigator.of(context).pushReplacement(FadeRoute(page: DetailsPage()));
   });
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

}
