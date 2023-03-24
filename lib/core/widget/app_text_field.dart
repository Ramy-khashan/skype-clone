import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final Function(dynamic value) onValidate;
  final Function(dynamic value) ?onChange;
  final TextEditingController? controller;
  final String ?label;
  final String? hint;
  final Widget? prefexIcon;
  final Function()? onPressShow;
  final bool isPassword;
  final bool isHidePassword;
  const AppTextField(
      {super.key,
      required this.onValidate,
        this.controller,
        this.label,
        this.hint,
        this.prefexIcon,
      this.onPressShow,
      this.onChange,
      this.isPassword = false,
      this.isHidePassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      
      child: TextFormField( 
        onChanged: onChange,
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
                      isHidePassword ? Icons.visibility : Icons.visibility_off,color: Colors.white,))
              : const SizedBox.shrink(),
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: const TextStyle(color: Colors.white),
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
