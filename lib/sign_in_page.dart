import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/sign_up_page.dart';
import 'package:green_app/splash.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  String _eMail;
  String _password;

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(15),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'E-Mail',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'E-Mail tidak boleh kosong';
                          } else {
                            if ((value.contains('penis')) |
                                (value.contains('vagina'))) {
                              return 'E-Mail tidak boleh mengandung unsur PORNOGRAFI';
                            }
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _eMail = newValue;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                            labelText: 'password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'password tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _password = newValue;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        child: Text('Sign In'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            print('email : $_eMail     password : $_password');

                            try {
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _eMail, password: _password);
                            } catch (e) {
                              print(e);
                            }

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Splash()));
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Text('Belum punya akun ?  '),
                        InkWell(
                          child: Text('Sign Up'),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                        )
                      ],
                    )
                  ],
                ))));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
