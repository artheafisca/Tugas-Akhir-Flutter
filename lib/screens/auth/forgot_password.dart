import 'package:e_wallet/model/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _email = TextEditingController();
  bool _isLoading = false;

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

  Widget _inputSubmit() {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.white))),
          onPressed: () => _loginSementara(),
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
      //           _loginSementara();
      //         },
      //         borderRadius: BorderRadius.circular(20),
      //         child: Center(
      //           child: Text(
      //             'Send',
      //             style: TextStyle(
      //                 color: Colors.white, fontWeight: FontWeight.w600),
      //           ),
      //         ),
      //       ),
      //     ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                wAuthTitle("Forgot Password",
                    "Enter you email and we\'ll send you to a link \nto reset your password"),
                SizedBox(
                  height: 10,
                ),
                _inputEmail(),
                _inputSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginSementara() async {
    setState(() {
      _isLoading = true;
    });

    if (_email.text.isNotEmpty) {
      print("BERHASIL");
      await Future.delayed(Duration(seconds: 2));

      Fluttertoast.showToast(
          msg: "Email sended! Please check your email to reset password.",
          backgroundColor: Colors.black,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          webPosition: "center");
      Navigator.pop(context);
    } else {
      print("GAGAL");
    }
  }
}
