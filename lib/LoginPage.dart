import 'package:flutter/material.dart';
import 'package:petrol_pump/RoundedTextField.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 300));
    _animation = Tween(begin: 200.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 1.5;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  height: layoutOneHeight,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Welcome to ",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Text(
                        "Petrol Pump",
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                ),
              SizedBox(
                height: _animation.value,
              ) ,

                Container(
                  height: (height - layoutOneHeight),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 22),
                        ),
                        alignment: Alignment.centerLeft,
                      ),

                      TextFormField(
                        decoration: InputDecoration(labelText: "I move"),
                        focusNode: _focusNode,
                      ),
                      RaisedButton(
                        child: Text("Submit"),
                        onPressed: null,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
