import 'package:e_wallet/model/color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../model/widget.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

User? userNow = FirebaseAuth.instance.currentUser;

class _TransferScreenState extends State<TransferScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nominal = TextEditingController();

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Transfer",
          style: GoogleFonts.poppins(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(userNow!.uid)
                  .snapshots(),
              builder: (context, snapshotdata) => ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  // var data2 = users.doc(id).snapshots();
                  if (data.id == userNow!.uid) {
                    return Container();
                  }
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Account Number",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data["rek"] ?? "",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                "Account Name",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data["name"] ?? "",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              "Transfer to " + data["name"],
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                            content: Padding(
                                padding: EdgeInsets.all(8),
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _nominal,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: "Nominal",
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                        ),
                                        // Align(
                                        //   alignment: Alignment.bottomRight,
                                        //   child: Text(
                                        //     "Rp. " +  data["saldo"].toString(),
                                        //     style: GoogleFonts.poppins(
                                        //         color: Colors.grey),
                                        //   ),
                                        // )
                                      ],
                                    ))),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  primaryColor)),
                                      child: Text("Back")),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            users.doc(data.id).update({
                                              "saldo": FieldValue.increment(
                                                  int.parse(_nominal.text))
                                            });

                                            users.doc(userNow!.uid).update({
                                              "saldo": FieldValue.increment(
                                                  -int.parse(_nominal.text))
                                            });

                                            users
                                                .doc(userNow!.uid)
                                                .collection("History")
                                                .add({
                                              "rek": userNow!.uid,
                                              "name": data["name"],
                                              "out": _nominal.text,
                                              "time": DateTime.now(),
                                              "status": "transfer"
                                            });

                                            users
                                                .doc(data.id)
                                                .collection("History")
                                                .add({
                                              "rek": userNow!.uid,
                                              "name":
                                                  snapshotdata.data!["name"],
                                              "out": _nominal.text,
                                              "time": DateTime.now(),
                                              "status": "topup"
                                            });
                                          });

                                          // Navigator.pop(context);

                                          Alert(
                                            context: context,
                                            type: AlertType.success,
                                            title: "Success",
                                            desc:
                                                "Your transaction is successful",
                                            buttons: [
                                              DialogButton(
                                                  color: primaryColor,
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.popUntil(
                                                          context, (route) {
                                                        return count++ == 3;
                                                      }))
                                            ],
                                          ).show();
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  primaryColor)),
                                      child: Text("Send")),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return wAppLoading();
          }
        },
      ),
    );
  }
}
