import 'package:flutter/material.dart';

class SelectDuration extends StatelessWidget {
  const SelectDuration({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.select,
  }) : super(key: key);

  final Function onPressed;
  final String label;
  final bool select;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed(),
      color: select ? Colors.green.withOpacity(.5) : Colors.grey,
      elevation: select ? 2 : 0,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
