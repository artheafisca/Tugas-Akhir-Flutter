import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_wallet/model/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Widget wAppLoading() {
  return Container(
    child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            color: primaryColor, size: 50)),
  );
}

Widget wAuthTitle(String title, String subtitle) {
  return Container(
    margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(subtitle)
      ],
    ),
  );
}

//Navigator push
Future wPushTo(BuildContext context, Widget widget) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

//Navigator pushReplacement
Future wPushReplaceTo(BuildContext context, Widget widget) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

final List<String> transactionItems = [
  'Transfer Bank',
  'Indomart',
  'Alfamart',
];

String? selectedValue;

@override
Widget wDropDown(BuildContext context) {
  return Form(
      child: DropdownButtonFormField2(
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
    isExpanded: true,
    hint: const Text(
      'Transfer Metode',
      style: TextStyle(fontSize: 14),
    ),
    icon: const Icon(
      Icons.arrow_drop_down,
      color: Colors.black45,
    ),
    iconSize: 30,
    buttonHeight: 60,
    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
    dropdownDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    items: transactionItems
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
        .toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select metode';
      }
    },
    onChanged: (value) {},
    onSaved: (value) {
      selectedValue = value.toString();
    },
  ));
}

Widget ButtonWidget(IconData iconsax, String title, VoidCallback callBack) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      OutlinedButton(
        onPressed: callBack,
        child: Icon(
          iconsax,
          color: primaryColor,
        ),
        style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            side: const BorderSide(color: Colors.transparent),
            padding: const EdgeInsets.all(16),
            elevation: 5,
            backgroundColor: Colors.white,
            shadowColor: Colors.grey.withOpacity(0.2)),
      ),
      SizedBox(
        height: 4,
      ),
      Text(title,
          style:
              GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400)),
    ],
  );
}
