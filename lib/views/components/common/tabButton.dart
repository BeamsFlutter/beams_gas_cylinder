

import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/material.dart';

import 'common.dart';
class TabButton extends StatelessWidget {


  final String? text;
  final int? selectedPage;
  final int? pageNumber;
  final Function  onPressed;
  final IconData  ? icon;
  final double width;
  final double ? radius;
  final bool ? isWhite;
  final double ? iconSize;
  TabButton({
    this.text,
    this.selectedPage,
    this.pageNumber,
    this.icon,
    this.radius,
    this.iconSize,
    required this.width,
    required this.onPressed, this.isWhite});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color fBgColor = (isWhite??false) ?white:primaryColor;
    Color fSBgColor = (isWhite??false) ?subColor.withOpacity(0.2):white;
    Color fStxtColor = (isWhite??false) ?subColor:Colors.black;
    Color fNtxtColor = (isWhite??false) ?subColor:white;

    return Container(
      width: size.width/2.1,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)) ,

      child: GestureDetector(
        onTap: (){
          onPressed();
        },
        child: AnimatedContainer(
          duration: const Duration(
              milliseconds: 1000
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
            color: selectedPage == pageNumber ? fSBgColor: fBgColor,
            borderRadius: BorderRadius.circular(radius??25.0),
          ),
          padding: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 12.0 : 12.0,
            horizontal: selectedPage == pageNumber ? 20.0 : 0,
          ),
          margin: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 0 : 0.0,
            horizontal: selectedPage == pageNumber ? 0 : 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(icon ?? null,
                  size: iconSize ?? 15,
                  color: selectedPage == pageNumber ? fStxtColor : fNtxtColor),
              ),
              gapWC(5),
              Text(
                text ?? "",
                style: TextStyle(
                  color: selectedPage == pageNumber ? fStxtColor : fNtxtColor,
                  fontSize: 10,
                  fontWeight: selectedPage==pageNumber?FontWeight.bold:FontWeight.normal
                ),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      ),
    );
  }
}