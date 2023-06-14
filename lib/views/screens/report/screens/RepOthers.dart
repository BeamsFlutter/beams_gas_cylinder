import 'package:beams_gas_cylinder/views/components/common/common.dart';
import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/material.dart';

class RepOthers extends StatefulWidget {
  const RepOthers({super.key});

  @override
  State<RepOthers> createState() => _RepOthersState();
}

class _RepOthersState extends State<RepOthers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: tc("Others", txtColor, 16)),
    );
  }
}
