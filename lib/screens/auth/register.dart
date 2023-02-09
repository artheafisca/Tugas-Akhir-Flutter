import 'package:e_wallet/model/color.dart';
import 'package:e_wallet/screens/auth/login.dart';
import 'package:e_wallet/screens/auth/verif_email.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/widget.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  Widget _regisTitle() {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              "Register",
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Create your account",
              style: GoogleFonts.poppins(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
      child: TextFormField(
        controller: _name,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(14, 15, 0, 8),
            hintText: "Name",
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }
          return null;
        },
      ),
    );
  }

  Widget _inputEmail() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
      child: TextFormField(
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: "Email",
            contentPadding: const EdgeInsets.fromLTRB(14, 15, 0, 8),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
      child: TextFormField(
        obscureText: _obscureText,
        controller: _password,
        decoration: InputDecoration(
            hintText: "Password",
            contentPadding: const EdgeInsets.fromLTRB(14, 15, 0, 8),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
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

          return null;
        },
      ),
    );
  }

  Widget _inputPasswordConfirm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
      child: TextFormField(
        obscureText: _obscureText,
        controller: _passwordConfirm,
        decoration: InputDecoration(
            hintText: "Confirm password",
            contentPadding: const EdgeInsets.fromLTRB(14, 15, 0, 8),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
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

          if (value != _password.text) {
            return "Password did\'t match";
          }

          return null;
        },
      ),
    );
  }

  Widget _inputSubmit() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.white))),
          onPressed: () async =>
              await _signUp(_email.text, _password.text, _name.text),
          child: Text(
            "Sign Up",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // child: Material(
      //   elevation: 2,
      //   borderRadius: BorderRadius.circular(20),
      //   child: Container(
      //     width: double.infinity,
      //     height: 40,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(20),
      //         gradient: LinearGradient(colors: [
      //           Colors.amber.shade900,
      //           Colors.amberAccent.shade400,
      //         ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      //     child: Material(
      //       borderRadius: BorderRadius.circular(20),
      //       color: Colors.transparent,
      //       child: InkWell(
      //         splashColor: Colors.white,
      //         onTap: () async =>
      //             await _signUp(_email.text, _password.text, _name.text),
      //         borderRadius: BorderRadius.circular(20),
      //         child: Center(
      //           child: Text(
      //             'Sign Up',
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

  Widget _haveAccount() {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: GoogleFonts.poppins(),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.transparent,
              child: Text(
                "Sign In",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () => Navigator.pop(context),
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
                backgroundColor: primaryColor,
                body: Form(
                  key: _formKey2,
                  child: Center(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.28,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/gambar.png"),
                                    fit: BoxFit.fitWidth)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.80,
                            child: Column(
                              children: [
                                _regisTitle(),
                                _inputName(),
                                _inputEmail(),
                                _inputPassword(),
                                _inputPasswordConfirm(),
                                _inputSubmit(),
                                _haveAccount()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _signUp(String email, String password, String name) async {
    if (_formKey2.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String Uid = userCredential.user!.uid;
        // await Future.delayed(Duration(seconds: 1));

        await firestore.collection('users').doc(Uid).set({
          "email": _email.text,
          "pass": _password.text,
          "name": _name.text,
          // "saldo": "",
          "rek": Uid
        });

        wPushReplaceTo(context, Login());

        
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        // User? user = FirebaseAuth.instance.currentUser;

        // if (user != null && !user.emailVerified) {
        //   await user.sendEmailVerification();
        // }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
