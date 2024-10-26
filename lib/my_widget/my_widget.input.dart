import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyWidgetInput extends StatelessWidget {
  const MyWidgetInput({super.key, this.keyboardType, this.hint, this.inputFormatters, this.maxLength, this.enabled, this.ctr, this.pass = false});
  final String? hint;
  final TextEditingController? ctr;
  final bool pass;
  final bool? enabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(),
      controller: ctr,
      obscureText: pass,
      enabled: enabled,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: '',
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade500)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0), borderSide: BorderSide(color: Colors.grey.shade300)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0), borderSide: BorderSide(color: Colors.grey.shade300)),
        fillColor: Colors.grey.shade100,
        suffixIconColor: Colors.blueAccent.shade100,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
      ),
    );
  }
}
