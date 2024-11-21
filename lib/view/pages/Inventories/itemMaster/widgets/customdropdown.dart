import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  int selectedValue = 20;
  final List<int> availableRowsPerPage = [10, 20, 50, 100];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedValue,
          isDense: true,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (newValue) {
            setState(() {
              if (newValue != null) {
                selectedValue = newValue;
              }
            });
          },
          items: availableRowsPerPage.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Row(
                children: [
                  Icon(
                    Icons.list,
                    color: Colors.blue,
                    size: 16,
                  ),
                  const SizedBox(width: 10),
                  Text('$value rows'),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
