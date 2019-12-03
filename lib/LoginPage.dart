import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId;
  AuthCredential authCredential;

  bool _visibility = true;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(toggleContainerVisibility);
  }

  void toggleContainerVisibility() {
    _visibility = false;
  }

  void sample() {

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      setState(() {
        print("Code Sent");
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      setState(() {
        print("Auto retrieval Time Out");
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      String message = authException.message;
      setState(() {
        print("Exception, $message");
      });
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      this.authCredential = auth;
      setState(() {
        print("Authentication Success");
      });

      firebaseAuth.signInWithCredential(auth).then((AuthResult value) {
        if(value.user != null){
          setState(() {
            print("Authentication Success");
          });
        }
        else{
          setState(() {
            print("Invalid Authentication Code");
          });
        }
      }).catchError((onError){
        setState(() {
          print("Error $onError");
        });
      });
    };

    firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+919656795221",
        timeout: Duration(seconds: 20),
        verificationCompleted: verificationCompleted,
        verificationFailed:verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }


  void SignInWithPhoneNumber(String smsCode) async{
    var _authCredential = await PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);

    firebaseAuth.signInWithCredential(_authCredential).catchError((onError){
      setState(() {
        print("Error In Manual Login");
      });
    }).then((onValue){
      print(onValue.user.displayName);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 1.5;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: _visibility,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Color(0xFFDEE7FF),
                        padding: EdgeInsets.only(top: 50),
                        margin: EdgeInsets.only(bottom: 8.0),
                        height: layoutOneHeight,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/loginImage.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Welcome to ",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Text(
                              "Petrol Pump",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
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
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 16.0),
                  height: (height - layoutOneHeight),
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 38.0, top: 2.0, right: 38.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 22),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 4.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 30.0),
                        height: 52,
                        width: double.infinity,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              hintText: "Phone Number"),
                          focusNode: _focusNode,
                        ),
                      ),
                      ButtonTheme(
                        height: 43,
                        minWidth: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
//                            Navigator.pushNamed(context, OtpPage.routeName);
                          sample();
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
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
