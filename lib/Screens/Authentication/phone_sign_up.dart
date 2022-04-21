import 'dart:async';

import 'package:eligere/Screens/Authentication/log_in.dart';
import 'package:eligere/Screens/CheckoutScreen/build_textformfield.dart';
import 'package:eligere/Screens/HomePage/stackofpages.dart';
import 'package:eligere/Screens/ProductScreen/Widgets/beautiful_button.dart';
import 'package:eligere/Services/auth_services.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../media_query.dart';
import 'Widgets/auth_title.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class Otp {
  int? first;
  int? second;
  int? third;
  int? forth;
  int? fifth;
  int? sixth;
}

Otp otp = Otp();

class _OtpPageState extends State<OtpPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FocusNode? firstNode;
  FocusNode? secondNode;
  FocusNode? thirdNode;
  FocusNode? forthNode;
  FocusNode? fifthNode;
  FocusNode? sixthNode;
  late List<FocusNode> nodes;
  late Animation<num> animation;
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController snameController = TextEditingController();

  late AnimationController controller;
  late Animation<double> secanimation;
  late AnimationController seccontroller;
  late num current;
  @override
  void initState() {
    super.initState();
    firstNode = FocusNode();
    secondNode = FocusNode();
    thirdNode = FocusNode();
    forthNode = FocusNode();
    fifthNode = FocusNode();
    sixthNode = FocusNode();
    nodes = [
      firstNode!,
      secondNode!,
      thirdNode!,
      forthNode!,
      fifthNode!,
      sixthNode!
    ];
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  focusNextNode(BuildContext context, FocusNode node, FocusNode fromthisone) {
    fromthisone.unfocus();
    FocusScope.of(context).requestFocus(node);
  }

  getNode(num number) {
    switch (number) {
      case 1:
        return firstNode = FocusNode();
        break;
      case 2:
        return secondNode = FocusNode();
      default:
    }
  }

  bool sent = false;
  String buttonName = 'Send';
  num start = 60.0;
  String? validationId;
  TextEditingController phoneNumberController = TextEditingController();
  setData(String validationID) {
    setState(() {
      validationId = validationID;
      duration = const Duration(minutes: 2);
    });
  }

  String validatePhone(String? value) {
    if (value!.length < 10) {
      //setState(() {
      return 'Please Enter Valid Phone Number';
      //});
    } else if (value.isEmpty) {
      return 'Phone number field cannot be left empty';
    } else {
      return '';
    }
  }

  void pushFCMtoken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('token: $token');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MQuery().init(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Column(
                  children: [
                    const AuthTitle(title: 'Register Account'),

                    //OtpTimer(),
                    //buildTimer(),
                    const SizedBox(
                      height: 35,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          buildTextFormField(
                            'First Name',
                            false,
                            (value) {},
                            fnamecontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildTextFormField(
                            'Surname',
                            false,
                            (value) {},
                            snameController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.phone,
                            //focusNode: focusNode,
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                                fillColor: Colors.grey,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter Phone Number ',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 20),
                                border: OutlineInputBorder(
                                  //borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'Phone',
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    '(+26)',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                suffixIcon: TextButton(
                                  onPressed: () async {
                                    if (validatePhone(
                                            phoneNumberController.text) ==
                                        '') {
                                      if (sent != true) {
                                        AuthService().verifyPhoneNumber(
                                            phoneNumberController.text,
                                            context,
                                            setData);
                                        setState(() {
                                          buttonName = 'Resend';

                                          sent = true;
                                          startTimer();
                                        });
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(validatePhone(
                                                      phoneNumberController
                                                          .text)
                                                  .toString())));
                                    }
                                  },
                                  child: Text(buttonName,
                                      style: TextStyle(
                                          color: !sent
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey)),
                                )),
                            //autofocus: true,
                            validator: (value) {
                              validatePhone(value);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          showOtpForm(context),
                          const SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return LogIn();
                                      },
                                    ));
                                  },
                                  child: const Text(
                                    'Log In Instead',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  )),
                            ],
                          ),
                          buildTimer(start),
                          const SizedBox(
                            height: 35,
                          ),
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: BeautifulButton(
                                  onTap: () async {
                                    if (_formkey.currentState!.validate()) {
                                      print(
                                          '${otp.first}${otp.second}${otp.third}${otp.forth}${otp.fifth}${otp.sixth}');
                                      _formkey.currentState!.save();
                                      final result = await AuthService()
                                          .signInWithPhoneNumber(
                                              validationId!,
                                              '${otp.first}${otp.second}${otp.third}${otp.forth}${otp.fifth}${otp.sixth}',
                                              context);
                                      if (result != false) {
                                        final user_doc = await Database()
                                            .users!
                                            .doc(result['user_c']
                                                .user
                                                .phoneNumber)
                                            .get();

                                        if (!user_doc.exists) {
                                          String? token =
                                              await FirebaseMessaging.instance
                                                  .getToken();
                                          Database().createUser({
                                            'token': token,
                                            'credentials':
                                                result['credentials'],
                                            'phone': result['user_c']
                                                .user
                                                .phoneNumber,
                                            'email':
                                                result['user_c'].user.email,
                                            'fName':
                                                fnamecontroller.text.trim(),
                                            'sName': snameController.text.trim()
                                          });
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return StackOfPages();
                                            },
                                          ));
                                        }
                                      }
                                      //AuthService().auth.signInWithCredential(AuthCredential())
                                      //Navigator.pushReplacementNamed(context, '/');
                                    } else {
                                      FocusScope.of(context)
                                          .requestFocus(firstNode);
                                    }
                                  },
                                  string: 'Continue'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row showOtpForm(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
          6,
          (index) => SizedBox(
              width: 45,
              child: TextFormField(
                focusNode: nodes[index],
                //autofocus: index == 1 ? true : false,
                style: const TextStyle(fontSize: 24),
                onChanged: (value) {
                  FocusScope.of(context).nextFocus();
                },
                onSaved: (newValue) {
                  switch (index) {
                    case 0:
                      otp.first = int.parse(newValue!);
                      break;
                    case 1:
                      otp.second = int.parse(newValue!);
                      break;
                    case 2:
                      otp.third = int.parse(newValue!);
                      break;
                    case 3:
                      otp.forth = int.parse(newValue!);
                      break;
                    case 4:
                      otp.fifth = int.parse(newValue!);
                      break;
                    case 5:
                      otp.sixth = int.parse(newValue!);
                      break;
                    default:
                  }
                },
                obscureText: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: otpInputDecoration(context),
                /*validator: (value) {
                              // ignore: unrelated_type_equality_checks
                              if (int.parse(value) != num) {
                                return 'Field cannot have letters';
                              }
                            },*/
              )),
        ),
      ],
    );
  }

  Duration duration = const Duration(minutes: 2);
  Timer? timer;
  buildTimer(num start) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60).toInt());
    final seconds = twoDigits(duration.inSeconds.remainder(60).toInt());
    return Text('Try again in $minutes:$seconds');
    /*return TweenAnimationBuilder(
      tween: Tween(begin: start, end: 0),
      duration: Duration(seconds: start.toInt()),
      onEnd: () {
        setState(() {
          start = 0.0;
          sent = false;
        });
      },
      builder: (context, num value, child) {
        return Text('00:${value.toInt()}');
      },
    );
 */
  }

  InputDecoration otpInputDecoration(BuildContext context) {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      addtime();
    });
  }

  void addtime() {
    if (duration.inMinutes == 0 && duration.inSeconds == 0) {
      setState(() {
        sent = false;
        duration = Duration(minutes: 2);
      });
    }
    setState(() {
      final seconds = duration.inSeconds - 1;
      duration = Duration(seconds: seconds);
    });
  }
}
