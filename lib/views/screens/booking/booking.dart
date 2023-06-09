

import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../components/common/common.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed:(){ }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: black),
        ),
        flexibleSpace: Container(
          decoration: boxDecoration(bgColor, 0),
        ),
        title:    tcn('Booking', black, 20),
        actions: const [   Padding(
          padding: EdgeInsets.all(12.0),
        ),],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.tag),
                    tc('text', black, 15)
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
