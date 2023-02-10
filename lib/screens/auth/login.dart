import 'package:e_wallet/model/color.dart';
import 'package:e_wallet/screens/auth/forgot_password.dart';
import 'package:e_wallet/screens/auth/register.dart';
import 'package:e_wallet/screens/auth/verif_email.dart';
import 'package:e_wallet/screens/home/ewallet_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _inputEmail() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: "Email",
            contentPadding: const EdgeInsets.fromLTRB(14, 15, 0, 8),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(30)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }

          if (!value.contains("@") || !value.contains(".")) {
            return "Invalid Email";
          }
          return null;
        },
      ),
    );
  }

  Widget _inputPassword() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
        child: TextFormField(
          controller: _password,
          obscureText: _obscureText,
          decoration: InputDecoration(
              hintText: "Password",
              contentPadding: const EdgeInsets.fromLTRB(14, 15, 0, 8),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(30)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Required";
            }

            if (value != null) {
              if (value.length < 6) {
                return "Min 6 character";
              }
            }

            //tes

            return null;
          },
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 12, 60, 0),
        child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
            )),
      )
    ]);
  }

  Widget _forgotPassword() {
    return GestureDetector(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(right: 40),
            padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
            child: Text(
              "Forgot Password?",
              style: GoogleFonts.poppins(),
            )),
      ),
      onTap: () => wPushTo(context, ForgotPassword()),
    );
  }

  Widget _inputSubmit() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              _signIn(_email.text, _password.text);
              _email.clear();
              _password.clear();
            },
            child: Text(
              "Sign In",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
        )
        // child: Material(
        //   elevation: 2,
        //   borderRadius: BorderRadius.circular(20),
        //   child: Container(
        //     width: double.infinity,
        //     height: 45,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         gradient: LinearGradient(colors: [
        //           Colors.amberAccent,
        //           Colors.amber,
        //         ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        //     child: Material(
        //       borderRadius: BorderRadius.circular(20),
        //       color: Colors.transparent,
        //       child: InkWell(
        //         splashColor: Colors.amber,
        //         onTap: () {
        //           _signIn(_email.text, _password.text);
        //         },
        //         borderRadius: BorderRadius.circular(20),
        //         child: Center(
        //           child: Text(
        //             'Sign In',
        //             style: TextStyle(
        //                 color: Colors.white, fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }

  Widget _backRegister() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: Row(
        children: [
          // Container(
          //     child:
          //         IconButton(onPressed: () {}, icon: Icon(EvaIcons.arrowBack))),
          SizedBox(
            width: 225,
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.transparent,
              child: Text(
                "Register",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () => wPushTo(context, Register()),
          )
        ],
      ),
    );
  }

  Widget _authTitle() {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign In",
            style: GoogleFonts.poppins(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Enter your email & password",
            style: GoogleFonts.poppins(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _isLoading
            ? wAppLoading()
            : Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _backRegister(),
                          SizedBox(
                            height: 10,
                          ),
                          _authTitle()
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Colors.white,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _inputEmail(),
                                _inputPassword(),
                                _forgotPassword(),
                                _inputSubmit(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          wPushReplaceTo(context, EwalletScreen());
        } else {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return VerifEmail();
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          print("No user found for that email.");
        } else if (e.code == "Wrong-password") {
          print("Wrong password provided for that user.");
        }
      }
    }
  }
}
