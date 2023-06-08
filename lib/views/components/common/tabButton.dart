

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
  final double ? iconSize;
  TabButton({
    this.text,
    this.selectedPage,
    this.pageNumber,
    this.icon,
    this.radius,
    this.iconSize,
    required this.width,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
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
            color: selectedPage == pageNumber ? Colors.white: Colors.transparent,
            borderRadius: BorderRadius.circular(radius??25.0),
          ),
          padding: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 12.0 : 0,
            horizontal: selectedPage == pageNumber ? 20.0 : 0,
          ),
          margin: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 0 : 12.0,
            horizontal: selectedPage == pageNumber ? 0 : 20.0,
          ),
          child: Row(
            children: [
              Container(
                child: Icon(icon ?? null,
                  size: iconSize ?? 15,
                  color: selectedPage == pageNumber ? Colors.black : Colors.white,),
              ),
              gapWC(5),
              Text(
                text ?? "",
                style: TextStyle(
                  color: selectedPage == pageNumber ? Colors.black : Colors.white,
                  fontSize: 10,
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