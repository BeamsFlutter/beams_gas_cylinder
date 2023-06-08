
import 'package:beams_gas_cylinder/views/components/common/textFieldContainer.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';



class RoundedInputField extends StatelessWidget {
  final String ? hintText;
  final IconData ? icon;
  final IconData ? suffixIcon;
  final ValueChanged<String> ? onChanged;
  final ValueChanged<String> ? onSubmit;
  final VoidCallback? onEditingComplete;
  final TextInputType ? textType;
  final TextEditingController ? txtController;
  final double ? txtWidth;
  final double ? txtRadius;
  final FocusNode ? focusNode;
  final Function ? suffixIconOnclick;
  final bool ? enablests;
  final bool ? autoFocus;
  final String ? labelYn;
  final double ? fontSize;

  const RoundedInputField({
    Key ? key,
    required this.hintText,
    this.icon,
    this.onChanged,
    this.textType,
    this.txtController,
    this.txtWidth,
    this.txtRadius,
    this.suffixIcon, this.onSubmit, this.focusNode,
    this.suffixIconOnclick, this.enablests, this.autoFocus,
    this.labelYn, this.onEditingComplete,
    this.fontSize
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {



    return TextFieldContainer(
      txtRadius: txtRadius ?? 29,
      txtWidth: txtWidth ?? 0.8,
      labelName: hintText ?? '',
      labelYn :  labelYn ??'N',
      child: TextFormField(
        enabled: enablests ?? true,
        focusNode: focusNode,
        autofocus: autoFocus??false,
        controller: txtController,
        onChanged: onChanged,
        cursorColor: primaryColor,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: suffixIconOnclick??fn(),
            child: Icon(
              suffixIcon,
              color: Colors.black ,
            ),
          ),
          hintText: hintText,

          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: fontSize,
        ),
        keyboardType: textType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onFieldSubmitted: onSubmit,


      ),
    );
  }
  fn(){

  }
}