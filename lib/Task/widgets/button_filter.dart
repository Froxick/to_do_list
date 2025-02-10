import 'package:flutter/material.dart';

class ButtonFilter extends StatelessWidget {
  final String filter;
  final String filterSetValue;
  final String buttonText;
  final void Function(String) onChangeFilter;

  ButtonFilter(
      {required this.buttonText,
      required this.filter,
      required this.filterSetValue,
      required this.onChangeFilter});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: filter == filterSetValue
                ? const Color.fromARGB(255, 103, 103, 103)
                : Colors.white),
        onPressed: () {
          onChangeFilter(filterSetValue);
        },
        child: Text(
          buttonText,
          style: TextStyle(
              color: filter == filterSetValue
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(255, 0, 0, 0)),
        ));
  }
}
