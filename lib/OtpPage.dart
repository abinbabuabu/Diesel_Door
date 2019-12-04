import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/profilePage.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpPage extends StatefulWidget {
  static const routeName = '/otpPage';
  final String phoneNumber;
  String veriId;
  final firebaseAuth = FirebaseAuth.instance;


  OtpPage(this.phoneNumber);

  @override
  _OtpPageState createState() => _OtpPageState();



}

class _OtpPageState extends State<OtpPage> {
  @override
  void initState() {
    super.initState();
      final PhoneCodeSent codeSent =
          (String verificationId, [int forceResendingToken]) async {
        widget.veriId = verificationId;
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
       widget.veriId = verificationId;
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException authException) {
       setState(() {
         print(authException.message);
       });
      };

      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential auth) {
        widget.firebaseAuth.signInWithCredential(auth).then((AuthResult value) {
          if (value.user != null) {

            setState(() {

            });

          } else {

          }
        }).catchError((onError) {});
      };

      widget.firebaseAuth.verifyPhoneNumber(
          phoneNumber: "+919656795221",
          timeout: Duration(seconds: 20),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);


  }

  @override
  Widget build(BuildContext context) {

    void SignInWithPhoneNumber(String smsCode) async {
      var _authCredential = PhoneAuthProvider.getCredential(verificationId: widget.veriId, smsCode: smsCode);
       await widget.firebaseAuth.signInWithCredential(_authCredential).catchError((onError){
      }).then((onValue){
        if(onValue  != null){
          print(onValue.user.phoneNumber);
        }
      });
    }

    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 1.5;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      color: Color(0xFFDEE7FF),
                      height: layoutOneHeight,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/building.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 38.0, right: 34.0, top: 16.0),
                  color: Colors.white,
                  height: height - layoutOneHeight,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("OTP Verification",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20)),
                            flex: 4,
                          ),
                          Expanded(
                            child: Text("00.00"),
                            flex: 1,
                          )
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: PinPut(
                            fieldsCount: 6,
                            unFocusWhen: false,
                            actionButtonsEnabled: false,
                            onSubmit: (number){
                              SignInWithPhoneNumber(number);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonTheme(
                          height: 43,
                          minWidth: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
