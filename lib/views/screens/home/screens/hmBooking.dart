import 'package:beams_gas_cylinder/views/components/common/common.dart';
import 'package:flutter/material.dart';

import '../../../styles/colors.dart';

class HmeBooking extends StatefulWidget {
  const HmeBooking({super.key});

  @override
  State<HmeBooking> createState() => _HmeBookingState();
}

class _HmeBookingState extends State<HmeBooking> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: tc("HomeBooking", black, 13),
      ),
    );
  }
}

