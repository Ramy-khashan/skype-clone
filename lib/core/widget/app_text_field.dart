import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final Function(dynamic value) onValidate;
  final TextEditingController controller;
  final String label;
  final Widget prefexIcon;
  final Function()? onPressShow;
  final bool isPassword;
  final bool isHidePassword;
  const AppTextField(
      {super.key,
      required this.onValidate,
      required this.controller,
      required this.label,
      required this.prefexIcon,
      this.onPressShow,
      this.isPassword = false,
      this.isHidePassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      
      child: TextFormField(
        autovalidateMode:AutovalidateMode.always ,
        obscureText: isPassword ? isHidePassword : false,
      controller: controller,
        validator: (value) => onValidate(value),
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          prefixIcon: prefexIcon,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onPressShow,
                  icon: Icon(
                      isHidePassword ? Icons.visibility : Icons.visibility_off))
              : const SizedBox.shrink(),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),
        ),
      ),
    );
  }
}
