import 'package:flutter/material.dart';

class PrioritySelector extends StatefulWidget {
  final String selctedPriority;
  final ValueChanged<String> onPriorityChanged;

  PrioritySelector(
      {super.key,
      required this.selctedPriority,
      required this.onPriorityChanged});

  @override
  _PrioritySelectorState createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PriorityBtn('green'),
          _PriorityBtn(
            'yellow',
          ),
          _PriorityBtn('red')
        ],
      ),
    );
  }

  Widget _PriorityBtn(String priority) {
    final isSelect = widget.selctedPriority == priority;
    final buttonClr = _getPriorityColor(priority);
    final backgroundColor = isSelect
        ? const Color.fromARGB(255, 209, 209, 209)
        : Colors.transparent;

    return InkWell(
      onTap: () {
        widget.onPriorityChanged(priority);
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: Duration(microseconds: 200),
        width: 35,
        height: 35,
        decoration:
            BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: Center(
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: buttonClr,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
