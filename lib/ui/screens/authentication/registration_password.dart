import 'package:flutter/material.dart';

class RegistrationPasswords extends StatefulWidget {
  TextEditingController lastName;
  TextEditingController imgUrl;
  RegistrationPasswords({
    super.key,
    required this.lastName,
    required this.imgUrl,
  });

  @override
  State<RegistrationPasswords> createState() => _RegistrationPasswordsState();
}

class _RegistrationPasswordsState extends State<RegistrationPasswords> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Parol bo'sh bo'lmasligi kerak";
            }
            return null;
          },
          controller: widget.lastName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Last Name",
            hintStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Parol bo'sh bo'lmasligi kerak";
            }
          },
          controller: widget.imgUrl,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: "Profile img url",
              hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
