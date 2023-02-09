import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifEmail extends StatefulWidget {
  const VerifEmail({super.key});

  @override
  State<VerifEmail> createState() => _VerifEmailState();
}

class _VerifEmailState extends State<VerifEmail> {
  bool _isLoading = false;
  bool _isSended = false;
  Widget _resendEmailButton() {
    return Column(
      children: [
        Text("Did\'t receive an email ?"),
        SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });

              await FirebaseAuth.instance.currentUser!.sendEmailVerification();
              // await Future.delayed(Duration(seconds: 2));

              setState(() {
                _isLoading = false;
                _isSended = true;
              });
            },
            child: Text(
              _isLoading ? "Sending.." : "Resend",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget _resendEmailMsg() {
    return Container(
      child: Text(
        "Email Sended!",
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  Widget _bottomWidget() {
    return _isSended ? _resendEmailMsg() : _resendEmailButton();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.2,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: Icon(Icons.drag_handle),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.alternate_email, size: 50),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Verify Your Email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We have send an email with a confirmation link\n to your email address.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(height: 40, indent: 50, endIndent: 50),
                Text(
                  "Please click on that to verify your email\n and continue the registration process",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Divider(height: 40, indent: 50, endIndent: 50),
                SizedBox(
                  height: 10,
                ),
                _bottomWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
