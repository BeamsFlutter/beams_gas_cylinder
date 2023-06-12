import 'package:beams_gas_cylinder/views/components/common/common.dart';
import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String ? hintText;
  final String ? pageMode;
  final IconData ? prefixIcon;
  final IconData ? suffixIcon;
  final VoidCallback ? suffixIconOnclick;
  final Color ? prefixIconColor;
  final TextEditingController ? txtController;
  final double ? txtSize;
  final int ? maxline;
  final bool obscureY;
  final TextStyle ? textStyle;
  final TextAlign ? textAlignment;
  final bool ? enableY;
  final bool? lookupY;
  final TextInputType? keybordType;
  final dynamic inputformate;
  final ValueChanged<String> ? onChanged;
  final ValueChanged<String> ? onSubmit;
  const CommonTextField({super.key, this.hintText, this.prefixIcon, this.prefixIconColor, this.txtController, this.txtSize, this.onChanged, this.onSubmit, required this.obscureY, this.suffixIcon, this.suffixIconOnclick, this.maxline,  this.lookupY, this.pageMode,  this.enableY, this.textStyle, this.keybordType, this.textAlignment, this.inputformate});

  @override
  Widget build(BuildContext context) {
    dprint("oooooooooooooooooo ${obscureY}");
    return  TextFormField(
      textAlign: textAlignment??TextAlign.start,
      enabled: enableY,
      keyboardType:keybordType ,
      decoration: InputDecoration(

          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500,),
          contentPadding: const EdgeInsets.all(15),


          border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: subColor),
              borderRadius: BorderRadius.circular(30),

          ),
          focusedBorder: OutlineInputBorder(
           borderSide: const BorderSide(width: 1, color: subColor),
           borderRadius: BorderRadius.circular(30),
    ),
          prefixIcon: Icon(prefixIcon,color: prefixIconColor,),
          suffixIcon: GestureDetector(
            onTap: suffixIconOnclick,
              child: Icon(suffixIcon)),


      
      ),
      controller: txtController,
      inputFormatters: inputformate,
      obscureText:obscureY,
      maxLines: maxline,
      style:textStyle ,
      onChanged: (value) {
        // do something
      },

    );
  }
}
