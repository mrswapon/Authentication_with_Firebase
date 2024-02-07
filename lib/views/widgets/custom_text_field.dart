import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Icon prifixicon;
  final Key? fieldKey;
  final bool? isPasswordField;
  final TextEditingController? controller;
  final String title;
  final Icon? sufixicons;
  final FormFieldValidator? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const CustomTextField({
    super.key,
    required this.title,
    required this.prifixicon,
    this.sufixicons,
    this.fieldKey,
    this.isPasswordField,
    this.controller,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.inputType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    bool obscureText = false;
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      key: widget.fieldKey,
      obscureText: widget.isPasswordField == true ? obscureText : false,
      validator: widget.validator,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: widget.prifixicon,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: widget.isPasswordField == true
                ? Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: obscureText == false ? Colors.blue : Colors.grey,
                  )
                : const Text(""),
          ),
          suffixIconColor: Colors.grey,
          prefixIconColor: Colors.grey,
          hintText: widget.title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.grey),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.grey),
          )),
    );
  }
}
