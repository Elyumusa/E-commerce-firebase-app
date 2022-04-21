import 'package:eligere/Screens/HomePage/home.dart';
import 'package:eligere/Screens/Payment/payment_screen.dart';
import 'package:eligere/Screens/ProductScreen/Widgets/beautiful_button.dart';
import 'package:eligere/Services/auth_services.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'Widgets/product_photo_container.dart';
import 'build_email_field.dart';
import 'build_textformfield.dart';

String addressInfo = 'Not yet entered address info, please do';
String? phone;
String? deliveryAddress;
String? fname;
String? sname;
String? email;
bool cod = true;
var paymentPayload = {
  "merchantTransactionID": '${DateTime.now().millisecondsSinceEpoch}',
  "requestAmount": '600',
  "currencyCode": "ZMW",
  "accountNumber": "ACC12345",
  "serviceCode": "E-CDEV6118",
  "dueDate": "${DateTime.now().add(Duration(days: 1))}",
  "requestDescription": "Getting E-Commerce service",
  "countryCode": "ZM",
  "customerFirstName": "",
  "customerLastName": "",
  "MSISDN": '',
  "customerEmail": "",
  'successRedirectUrl': "https://success.com",
  'failRedirectUrl': 'https://failed.com',
  "paymentWebhookUrl": "https://dbe8986f7b620debf82365b77272c12c.m.pipedream.ne"
};
// "https://hooks.slack.com/services/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"
List? cart;

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController fnameController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late SharedPreferences prefs;
  TextEditingController phoneController = TextEditingController();
  // WebViewController _controller;
  num addCartSubTotal(List? products) {
    num totalSoFar = 0;
    for (var map in products!) {
      num producttotal = int.parse('${map['product'].get('price')}') *
          int.parse('${map['quantity']}');
      print('$producttotal');
      totalSoFar += producttotal;
    }

    return totalSoFar;
  }

  @override
  void initState() {
    // TODO: implement initState
    getPrefs();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cart = MyHomePage.of(context).blocProvider.cartBloc.cart;
    super.didChangeDependencies();
  }

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('fname') != null) {
      fnameController.text = prefs.getString('fname')!;
      snameController.text = prefs.getString('sname')!;
      addressController.text = prefs.getString('address')!;
      emailController.text = prefs.getString('email')!;
      phoneController.text = prefs.getString('phone')!;
    }
  }

  String button = 'Enter Info';
  late num carttotal;
  @override
  Widget build(BuildContext context) {
    List cartArrSellers = [];
    carttotal = addCartSubTotal(cart);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Column(
            children: [
              const Text(
                'Check Out',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                '${cart!.length} items',
                style: const TextStyle(color: Colors.black26, fontSize: 15),
              )
            ],
          ),
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 35,
                color: Colors.black,
              )),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -5),
                      blurRadius: 20,
                      color: Colors.black26)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text.rich(TextSpan(
                            text: 'Sub-total: ',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 20),
                            children: [
                              TextSpan(
                                  text: 'K$carttotal',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ])),
                        Text.rich(TextSpan(
                            text: 'Delivery: ',
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 20),
                            children: [
                              TextSpan(
                                  text: 'K$carttotal',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ])),
                        Text.rich(TextSpan(
                            text: 'Total: ',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 20),
                            children: [
                              TextSpan(
                                  text: 'K${addCartSubTotal(cart)}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ])),
                      ]),
                  SizedBox(
                    width: 200,
                    child: BeautifulButton(
                      onTap: () async {
                        if (button == 'Enter Info') {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            setState(() {
                              button = 'Proceed';
                            });
                          }
                        } else {
                          await prefs.setString('fname', fnameController.text);
                          await prefs.setString('sname', snameController.text);
                          await prefs.setString(
                              'address', addressController.text);
                          await prefs.setString('phone', phoneController.text);
                          await prefs.setString('email', emailController.text);
                          if (cod == false) {
                            await _handlePaymentInitialization();
                          } else {
                            await Database().orders!.doc('First').set({
                              'user_id': 'Elyumusa',
                              'order_id': '',
                            });
                          }
                          /* try {
                            String? token =
                                await FirebaseMessaging.instance.getToken();
                            await Database()
                                .users
                                .doc('Elyumusa')
                                .collection('Tokens')
                                .add({'token': token!});
                            await Database()
                                .orders
                                .doc('First')
                                .set({'user_id': 'Elyumusa'});
                          } on Exception catch (e) {
                            print(e);
                          }*/
                          /*Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return PaymentScreen();
                            },
                          ));*/
                          //
                        }
                      },
                      string: button,
                    ), /*WebView(
                      initialUrl: initialUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) =>
                          _controller = controller,
                    ),*/
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          child: Row(children: [
                            GestureDetector(
                              onTap: () {
                                if (cod != true)
                                  setState(() {
                                    cod = true;
                                  });
                              },
                              child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  //width: 120,
                                  child: Center(
                                      child: Text('Cash On Delivery',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: cod
                                                  ? Colors.white
                                                  : Colors.black))),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          cod ? kPrimaryColor : Colors.white)),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (cod != false)
                                  setState(() {
                                    cod = false;
                                  });
                              },
                              child: Container(
                                  height: 50,
                                  width: 120,
                                  child: Center(
                                      child: Text('Pay Now',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: !cod
                                                  ? Colors.white
                                                  : Colors.black))),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          !cod ? kPrimaryColor : Colors.white)),
                            )
                          ]),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2), color: Colors.black26)
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Your Cart',
                            style:
                                TextStyle(color: Colors.black, fontSize: 21)),
                      ],
                    ),
                    Container(
                      height: 150,
                      margin: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 14),
                      child: ListView.builder(
                        itemCount: cart!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(right: 12),
                              width: 180,
                              child: ProductPhotoContainer(
                                  image: cart![index]['product'].get('photo')));
                        },
                      ),
                    ),
                    /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your Address',
                        style: TextStyle(color: Colors.black, fontSize: 21)),
                    TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                      onPressed: () {
                                        if (_formkey.currentState.validate()) {
                                          _formkey.currentState.save();
                                          setState(() {});
                                          paymentPayload["customerFirstName"] =
                                              fname;
                                          paymentPayload["customerLastName"] =
                                              sname;
                                          paymentPayload["MSISDN"] =
                                              phoneController.text;
                                          paymentPayload["customerEmail"] = email;
                
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text('Save'))
                                ],
                                content: Form(
                                  key: _formkey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                          onSaved: (value) {
                                            email = value;
                                          },
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          keyboardType: TextInputType.phone,
                                          //focusNode: focusNode,
                                          controller: phoneController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            hintText: 'Enter Phone Number ',
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 42, vertical: 20),
                                            border: OutlineInputBorder(
                                              //borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            //labelText: 'Phone',
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                '(+26)',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          autofocus: true,
                                          validator: validatePhone),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      buildEmailFormField(emailController,
                                          onSaved: (value) {
                                        email = value;
                                      }),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      buildTextFormField('First Name', false,
                                          (value) {
                                        fname = value;
                                      }, fnameController),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      buildTextFormField('Surname', false,
                                          (value) {
                                        sname = value;
                                      }, snameController),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      buildTextFormField('Address', false,
                                          (value) {
                                        deliveryAddress = value;
                                      }, addressController)
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text('Edit Address',
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.normal))),
                  ],
                              ),
                              */
                    fname == null ? const Text('') : Text('$fname'),
                    const SizedBox(
                      height: 5,
                    ),
                    email == null ? const Text('') : Text('$email'),
                    deliveryAddress == null
                        ? const Text("")
                        : Text(
                            deliveryAddress!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Delivery Details',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 21))
                        ],
                      ),
                    ),
                    Text(
                      'Will be received on ${DateFormat.yMMMd().format(DateTime.now().add(Duration(hours: 24)))} at your doorstep, if more queries will be needed we shall contact you on the number you provided in the Address info section',
                      //maxLines: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                              onSaved: (value) {
                                phone = value;
                                phoneController.text = value!;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              //focusNode: focusNode,
                              controller: phoneController,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter Phone Number ',
                                labelText: 'Phone',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 20),
                                border: OutlineInputBorder(
                                  //borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                //labelText: 'Phone',
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    '(+26)',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              autofocus: true,
                              validator: (value) {
                                validatePhone(value);
                              }),
                          SizedBox(
                            height: 12,
                          ),
                          BuildEmailField(
                            controller: emailController,
                            onSaved: (value) {
                              email = value;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextFormField(
                            'First Name',
                            false,
                            (value) {
                              fname = value;
                            },
                            fnameController,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextFormField(
                            'Surname',
                            false,
                            (value) {
                              sname = value;
                            },
                            snameController,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextFormField(
                            'Address',
                            false,
                            (value) {
                              deliveryAddress = value;
                            },
                            addressController,
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }

  validatePhone(String? value) {
    if (value!.length < 10) {
      //setState(() {
      return 'Please Enter Valid Phone Number';
      //});
    } else if (value.isEmpty) {
      return 'Phone number field cannot be left empty';
    } else {
      return null;
    }
  }

  Future _handlePaymentInitialization() async {
    final flutterwave = Flutterwave.forUIPayment(
        amount: '$carttotal',
        currency: FlutterwaveCurrency.ZMW,
        context: context,
        publicKey: "FLWPUBK_TEST-07a0f1e2460fd8782034ee7136ceab3f-X",
        encryptionKey: "FLWSECK_TEST2a23d4c6a567",
        email: emailController.text.trim(),
        fullName:
            "${fnameController.text.trim()} ${snameController.text.trim()}",
        txRef: DateTime.now().toIso8601String(),
        narration: "Example Project",
        isDebugMode: false,
        phoneNumber: '+26${phoneController.text.trim()}',
        acceptAccountPayment: true,
        acceptZambiaPayment: true,
        acceptCardPayment: true,
        acceptUSSDPayment: true);
    final response = await flutterwave.initializeForUiPayments();
    if (response != null) {
      print('payment response:  ${response.data!.status}');
      // response.data.
      if (response.data!.status == 'Success') {
        await Database()
            .orders!
            .doc(DateTime.now().microsecondsSinceEpoch.toString())
            .set({
          'user_id': AuthService().auth.currentUser!.uid,
          'address': addressController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'products': cart!.map((e) => e['product'].id).toList(),
          'total': '$carttotal',
          'status': 'In Transit'
        });
        showLoading(response.data!.status!);
      } else {
        showLoading(response.data!.status!);
      }

      return true;
    } else {
      return false;
      showLoading("No Response!");
    }
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
