import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/widget.dart';

User? user = FirebaseAuth.instance.currentUser;

class _chartData {
  final DateTime? x;
  final int y;

  _chartData({required this.x, required this.y});
  _chartData.fromMap(Map<String, dynamic> dataMap)
      : x = dataMap["x"],
        y = dataMap["y"];
}

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<_chartData> chartData = <_chartData>[];

  Future<void> getDataFromFirestore() async {
    var snapshotValue = await FirebaseFirestore.instance
        .collection("users/${user!.uid}/History")
        .get();
    List<_chartData> list = snapshotValue.docs
        .map((e) =>
            _chartData(x: DateTime(e.data()["time"]), y: e.data()["out"]))
        .toList();
    setState(() {
      chartData = list;
    });
  }

  @override
  void initState() {
    getDataFromFirestore().then((result) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference history =
        FirebaseFirestore.instance.collection("users/${user!.uid}/History");
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: history.snapshots(),
        builder: (BuildContext context, snapshot) {
          // if (snapshot.hasData) {
          //   List<_chartData> chartData = <_chartData>[];
          //   for (int index = 0; index < snapshot.data.docs.length; index+) {
          //     DocumentSnapshot documentSnapshot = snapshot.data.docs[index];

          //     chartData.add(chartData.fromMap(documentSnapshot.data()));
          //   }
          // }
          double sum = 0;
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['status'] == 'payment' &&
                  snapshot.data!.docs[i]['status'] == 'transfer') {
                sum += int.parse(snapshot.data!.docs[i]['out']);
              }
            }
          }
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text("Total balance",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400)),
                Text("Rp. ${sum.toString()}",
                    style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent)),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Income Stats",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                    Text("Oct - Feb",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                  ],
                ),
                // Container(
                //   child: SfCartesianChart(
                //     primaryXAxis: DateTimeAxis(),
                //     series: <ChartSeries<_chartData, dynamic>>[
                //       ColumnSeries<_chartData, dynamic>(dataSource: _chartData, xValueMapper: (_chartData data,_) => data.x, yValueMapper: (_chartData data,_) => data.y)
                //     ],
                //   ),
                // ),
                Container(
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    // primaryYAxis: NumericAxis(),
                    series: <ChartSeries<_chartData, DateTime>>[
                      LineSeries(
                          dataSource: chartData,
                          xValueMapper: (_chartData data, _) => data.x,
                          yValueMapper: (_chartData data, _) => data.y)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
