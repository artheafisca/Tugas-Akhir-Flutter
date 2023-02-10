import 'package:e_wallet/model/color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryTransfer extends StatelessWidget {
  const HistoryTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference history =
        FirebaseFirestore.instance.collection("users/${user!.uid}/History");
    return SingleChildScrollView(
      child: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: history.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text(
                "data doesn\'t exist",
                style: GoogleFonts.poppins(),
              ));
            }
            if (snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];

                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: secondColor,
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  if (data['status'] == 'transfer') ...[
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data["name"],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(data["status"],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Text(
                                          "- " + data["out"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 14, color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ] else if (data['status'] == 'topup') ...[
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data["name"],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(data["status"],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Text(
                                          "+ " + data["out"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.green),
                                        )
                                      ],
                                    ),
                                  ] else ...[
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data["name"],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(data["status"],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Text(
                                          "- " + data["out"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 14, color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ]
                                ],
                              )),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Center(
                                  child: Text(
                                "Transaction Details",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              )),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Name",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    data["name"],
                                    style:
                                        GoogleFonts.poppins(color: Colors.grey),
                                  ),
                                  Text(
                                    "Account Number",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    data["rek"],
                                    style:
                                        GoogleFonts.poppins(color: Colors.grey),
                                  ),
                                  Text(
                                    "Nominal",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    data["out"],
                                    style:
                                        GoogleFonts.poppins(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      "D O N E",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Back",
                                      style: GoogleFonts.poppins(),
                                    ))
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
              return Center(
                child: Text("- Data doesn\'t exist"),
              );
            }
          },
        ),
      ),
    );
  }
}
