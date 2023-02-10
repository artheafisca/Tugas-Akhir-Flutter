import 'package:e_wallet/model/color.dart';
import 'package:e_wallet/screens/home/history_home.dart';
import 'package:e_wallet/screens/home/history_tf.dart';
import 'package:e_wallet/screens/home/notif_screen.dart';
import 'package:e_wallet/screens/home/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../model/widget.dart';

const List<String> list = <String>['Transfer Bank', 'Indomart', 'Alfamart'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

User? userNow = FirebaseAuth.instance.currentUser;

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = list.first;
  TextEditingController _nominal = TextEditingController();
  TextEditingController _tujuan = TextEditingController();
  TextEditingController _topUp = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int count = 0;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
// User? user = FirebaseAuth.instance.currentUser;
    String uid = auth.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference history =
        FirebaseFirestore.instance.collection("users/${userNow!.uid}/History");

    return SingleChildScrollView(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return wAppLoading();
            }
            var data = snapshot.data!.data();
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Wallet",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 2,
                          ),
                          Text("Active",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Balance",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                  data!["saldo"] == null
                                      ? "Rp. 0"
                                      : "Rp. ${data["saldo"]}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Card",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 2,
                              ),
                              Text(data["name"],
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonWidget(Iconsax.convert, "Transfer", () {
                        wPushTo(context, TransferScreen());
                      }),
                      ButtonWidget(Iconsax.export, "Payment", () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Center(
                                child: Text("Payment",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
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
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30))),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: _tujuan,
                                            decoration: InputDecoration(
                                                hintText: "Payment",
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30))),
                                          ),
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
                                        onPressed: () async {
                                          // print(int.parse(_nominal.text) + saldoAwal);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            CollectionReference data =
                                                FirebaseFirestore.instance
                                                    .collection("users");
                                            await data
                                                .doc(userNow!.uid)
                                                .update({
                                              "saldo": FieldValue.increment(
                                                  -int.parse(_nominal.text))
                                              // int.parse(_nominal.text) + saldoAwal
                                            });

                                            users
                                                .doc(userNow!.uid)
                                                .collection("History")
                                                .add({
                                              "rek": userNow!.uid,
                                              "name": snapshot.data!['name'],
                                              "out": _nominal.text,
                                              "payment": _tujuan.text,
                                              "time": DateTime.now(),
                                              "status": "payment"
                                            });

                                            sweatAlert(context);
                                             _nominal.clear();
                                             _tujuan.clear();
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
                      }),
                      // ButtonWidget(Iconsax.money_send, "Payout", () {}),
                      ButtonWidget(Iconsax.add, "Top Up", () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text("Top Up",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30))),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          wDropDown(context),
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
                                        onPressed: () async {
                                          // print(int.parse(_nominal.text) + saldoAwal);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            CollectionReference data =
                                                FirebaseFirestore.instance
                                                    .collection("users");
                                            await data
                                                .doc(userNow!.uid)
                                                .update({
                                              "saldo": FieldValue.increment(
                                                  int.parse(_nominal.text))
                                              // int.parse(_nominal.text) + saldoAwal
                                            });

                                            users
                                                .doc(userNow!.uid)
                                                .collection("History")
                                                .add({
                                              "rek": userNow!.uid,
                                              "name": snapshot.data!['name'],
                                              "out": _nominal.text,
                                              "time": DateTime.now(),
                                              "status": "topup"
                                            });

                                            // Navigator.pop(context);

                                            sweatAlert(context);
                                            _nominal.clear();
                                          }
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    primaryColor)),
                                        child: Text("Add")),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Last Transaction",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () => NotifScreen(),
                        child: Text("View All",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      )
                    ],
                  ),
                  Container(
                    child: HistoryHome(),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void sweatAlert(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Your transaction is successful",
      buttons: [
        DialogButton(
            color: primaryColor,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () => Navigator.popUntil(context, (route) {
                  return count++ == 2;
                }))
      ],
    ).show();
    return;
  }
}
