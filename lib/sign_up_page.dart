import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/sign_in_page.dart';
import 'package:green_app/splash.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordTC = TextEditingController();

  String _eMail;
  String _password;
  bool _isHidden = true;
  bool _isHidden2 = true;

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
                            prefixIcon: Icon(Icons.mail)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'E-Mail tidak boleh kosong';
                          } else {
                            if (value.length < 5) {
                              return 'E-Mail tidak boleh kurang dari 5 karakter';
                            } else {
                              if ((value.contains('penis')) |
                                  (value.contains('vagina'))) {
                                return 'E-Mail tidak boleh mengandung unsur PORNOGRAFI';
                              }
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
                        controller: passwordTC,
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
                          } else {
                            if (value.length < 5) {
                              return 'password tidak boleh kurang dari 5 karakter';
                            }
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
                      child: TextFormField(
                        obscureText: _isHidden2,
                        decoration: InputDecoration(
                            labelText: 'konfirmasi password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView2,
                              child: Icon(_isHidden2
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'password tidak boleh kosong';
                          }
                          if (passwordTC.text != value) {
                            return 'Password tidak sama';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        child: Text('Sign Up'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            try {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _eMail, password: _password);
                            } catch (e) {
                              print(e);
                            }

                            print('email : $_eMail     password : $_password');
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
                        Text('Sudah punya akun ?  '),
                        InkWell(
                          child: Text('Sign In'),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
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

  void _togglePasswordView2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }
}
