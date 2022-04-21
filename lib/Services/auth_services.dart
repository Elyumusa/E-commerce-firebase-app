import 'package:eligere/Screens/HomePage/stackofpages.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get user {
    return auth.authStateChanges();
    //.map((event) => createNormalUserFromFirebaseUser(event));
  }

  Future signInWithPhoneNumber(
      String verificationID, String code, BuildContext context) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: code);
    late UserCredential usercredential;
    try {
      usercredential = await auth.signInWithCredential(credential);
      return {
        'credentials': {
          'providerId': credential.providerId,
          'signInMethod': credential.signInMethod,
          'token': credential.token
        },
        'user_c': usercredential
      };
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.toString()),
        ),
      );
      return false;
      // showSnackBar(e.toString(), context);
    }
  }

  verifyPhoneNumber(String phoneNumber, BuildContext context, Function setData,
      {String? fname, String? sname}) async {
    // ignore: prefer_function_declarations_over_variables
    //Triggered when an SMS is auto-retrieved or the phone number has been instantly verified
    // ignore: prefer_function_declarations_over_variables
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      late UserCredential usercredential;
      late Map result;
      try {
        usercredential = await auth.signInWithCredential(phoneAuthCredential);
        result = {
          'credentials': {
            'providerId': phoneAuthCredential.providerId,
            'signInMethod': phoneAuthCredential.signInMethod,
            'token': phoneAuthCredential.token
          },
          'user_c': usercredential
        };
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(e.toString()),
          ),
        );

        // showSnackBar(e.toString(), context);
      }
      final userDoc =
          await Database().users!.doc(result['user_c'].user.phoneNumber).get();
      if (!userDoc.exists) {
        String? token = await FirebaseMessaging.instance.getToken();
        Database().createUser({
          'token': token,
          'credentials': result['credentials'],
          'phone': result['user_c'].user.phoneNumber,
          'email': result['user_c'].user.email,
          'fName': fname,
          'sName': sname
        });
      }
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const StackOfPages();
        },
      ));
      showSnackBar('Verification Compeleted successfully', context);
    };
    //Triggered when an error occurred during phone number verification. A [FirebaseAuthException] is provided when this is triggered.
    // ignore: prefer_function_declarations_over_variables
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      print('error: ${exception.message}');
      showSnackBar(exception.message, context);
    };
    //Triggered when an SMS has been sent to the users phone
    // ignore: prefer_function_declarations_over_variables
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) {
      showSnackBar('Verification Code sent on the phone Number', context);
      setData(verificationId);
    };
    // ignore: prefer_function_declarations_over_variables
    //Triggered when SMS auto-retrieval times
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar('Time Out', context);
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber:
              phoneNumber.startsWith('+26') ? phoneNumber : '+26${phoneNumber}',
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(minutes: 2),
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  showSnackBar(String? message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message!)));
  }

  Future<bool> signUp(String email, String password) async {
    print('Its here');
    try {
      print('Its also here');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential);
      print('But here its worked');
      User? user = userCredential.user;

      return true;
    } on FirebaseAuthException catch (e) {
      print('Its here not');
      print(e.message);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    }
  }
}
