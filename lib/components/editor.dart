import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? description;
  final IconData? icon;

  Editor({
    this.controller,
    this.title,
    this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: title,
          hintText: description,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
