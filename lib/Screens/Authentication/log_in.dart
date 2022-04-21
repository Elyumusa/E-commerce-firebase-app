import 'package:eligere/Screens/Authentication/Widgets/auth_title.dart';
import 'package:eligere/Screens/HomePage/stackofpages.dart';
import 'package:eligere/Screens/ProductScreen/Widgets/beautiful_button.dart';
import 'package:eligere/Services/auth_services.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  FocusNode firstNode = FocusNode();
  String error = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 150,
              ),
              const AuthTitle(title: 'Log In'),
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.phone,
                //focusNode: focusNode,
                controller: phoneNumberController,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Enter Phone Number ',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                  border: OutlineInputBorder(
                    //borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Phone',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '(+26)',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                //autofocus: true,
                validator: (value) {
                  validatePhone(value);
                },
              ),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: BeautifulButton(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          final user_doc = await Database()
                              .users!
                              .doc(phoneNumberController.text.startsWith('+26')
                                  ? phoneNumberController.text.trim()
                                  : '+26${phoneNumberController.text}')
                              .get();

                          if (user_doc.exists) {
                            print('c: ${user_doc.get('credentials')}');
                            final credential = AuthCredential(
                                providerId:
                                    user_doc.get('credentials')['providerId'],
                                signInMethod:
                                    user_doc.get('credentials')['signInMethod'],
                                token: user_doc.get('credentials')['token']);

                            try {
                              final result = await AuthService()
                                  .auth
                                  .signInWithCredential(credential);
                            } on Exception catch (e) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return StackOfPages();
                              },
                            ));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                content: Text(
                                    'User With this phone Number does not exist'),
                              ),
                            );
                          }
                        } else {
                          FocusScope.of(context).requestFocus(firstNode);
                        }

                        //AuthService().auth.signInWithCredential(AuthCredential())
                        //Navigator.pushReplacementNamed(context, '/');
                      },
                      string: 'Continue'),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      )),
    );
  }

  String validatePhone(String? value) {
    if (value!.length < 10) {
      setState(() {
        error = 'Please Enter Valid Phone Number';
      });
      return 'Please Enter Valid Phone Number';
    } else if (value.isEmpty) {
      setState(() {
        error = 'Phone number field cannot be left empty';
      });
      return 'Phone number field cannot be left empty';
    } else {
      setState(() {
        error = '';
      });
      return '';
    }
  }
}
