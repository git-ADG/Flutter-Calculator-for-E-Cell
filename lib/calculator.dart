import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //result display
          Expanded(
              child: Container(
            color: Colors.red,
          )),
          //buttons
          Row(
            children: [
              button()
            ],
          )
        ],
      ),
    );
  }

  Widget button() {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(22)),
        onPressed: () {},
        child: const Text(
          "1",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
      ),
    ));
  }
}
