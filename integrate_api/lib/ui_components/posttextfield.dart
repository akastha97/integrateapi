import 'package:flutter/material.dart';

class PostTextfield extends StatefulWidget {
  const PostTextfield({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PostTextfield> createState() => _PostTextfieldState();
}

class _PostTextfieldState extends State<PostTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      decoration: const InputDecoration(
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          label: Text("Title"),
          hintText: "Title",
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      controller: widget.controller,
    );
  }
}
