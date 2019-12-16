import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  PhoneNumberEntered,
  AuthenticatedNewUser
}

class LoginProvider with ChangeNotifier {
  //Variables
  FirebaseAuth _auth;
  FirebaseUser _user;
  String _phoneNumber;
  Status _status = Status.Uninitialized;
  static String _verificationId;

  PhoneCodeSent _codeSent;
  PhoneCodeAutoRetrievalTimeout _codeAutoRetrievalTimeout;
  PhoneVerificationFailed _verificationFailed;
  PhoneVerificationCompleted _verificationCompleted;

  //Getters

  static String get verificationId => _verificationId;

  PhoneCodeSent get codeSent => _codeSent;

  PhoneCodeAutoRetrievalTimeout get codeAutoRetrievalTimeout =>
      _codeAutoRetrievalTimeout;

  PhoneVerificationFailed get verificationFailed => _verificationFailed;

  PhoneVerificationCompleted get verificationCompleted =>
      _verificationCompleted;

  String get phoneNumber => _phoneNumber;

  Status get status => _status;
  FirebaseUser get user => _user;
  FirebaseAuth get auth => _auth;

  //Setters

  set phoneNumber(String newValue) {
    _phoneNumber = "+91"+newValue;
    _status = Status.PhoneNumberEntered;
    notifyListeners();
  }

  //instance

  LoginProvider.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);

    _codeSent = (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
    };

    _codeAutoRetrievalTimeout = (String verificationId) {
      _verificationId = verificationId;
    };

    _verificationFailed = (AuthException authException) {
      _status = Status.Unauthenticated;
      print(authException.message);
      notifyListeners();
    };

    _verificationCompleted = (AuthCredential auth) {
      _auth.signInWithCredential(auth).then((AuthResult value) {
        if (value.user != null) {
          if(value.additionalUserInfo.isNewUser){
            _status = Status.AuthenticatedNewUser;
          }
          else{
            _status = Status.Authenticated;
          }

        } else {
          _status = Status.Unauthenticated;
        }
      }).catchError((onError) {
        _status = Status.Unauthenticated;
      });
    };
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
    }
    notifyListeners();
  }

  void SignInWithPhoneNumber(String smsCode) async {
    var _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: smsCode);

    await _auth
        .signInWithCredential(_authCredential)
        .catchError((onError) {})
        .then((onValue) {
      if (onValue != null) {
        print(onValue.user.phoneNumber);
        print("Logged IN ");
        _status = Status.Authenticated;
        notifyListeners();
      }
    });
  }
}
