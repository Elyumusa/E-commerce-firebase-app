import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/CheckoutScreen/checkout.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  Database() {
    //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 9000);
    users = FirebaseFirestore.instance.collection('Users');
    orders = FirebaseFirestore.instance.collection('Orders');
  }
  CollectionReference? users;
  CollectionReference? orders;
  CollectionReference products =
      FirebaseFirestore.instance.collection('Products');
  createUser(Map user) async {
    await users!.doc(user['phone']).set({
      'credentials': user['credentials'],
      'phone': user['phone'],
      'email': user['email'],
      'f_name': user['fName'],
      's_name': user['sName'],
      'my_cart': []
    });
    await users!
        .doc(user['phone'])
        .collection('Tokens')
        .doc(user['token'])
        .set({'token': user['token']});
  }
}
