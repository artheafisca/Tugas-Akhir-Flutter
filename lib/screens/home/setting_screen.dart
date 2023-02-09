import 'package:e_wallet/model/color.dart';
import 'package:e_wallet/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/widget.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String uid = auth.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return wAppLoading();
            }
            var data = snapshot.data!.data();
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data!["name"],
                                style: GoogleFonts.poppins(fontSize: 24),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      EvaIcons.google,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      data["email"],
                                      style: GoogleFonts.poppins(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                data["rek"],
                                style: GoogleFonts.poppins(fontSize: 15,color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Account Settings",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 14),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Account Security",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Email Notification Preferences",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Privacy",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      Text(
                        "Support",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 14),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                        title: Text(
                          "About E-Wallet",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                        title: Text(
                          "FAQs",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Share the e-wallet app",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      Text(
                        "Diagnostics",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 14),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Status",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor)),
                          onPressed: () {
                            logout(context);
                          },
                          child: Text(
                            "Sign Out",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text(
                            "buildWithArthea",
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> logout(BuildContext context) async {
    wAppLoading();
    await FirebaseAuth.instance.signOut();
    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
    wPushReplaceTo(context, Login());
  }
}
