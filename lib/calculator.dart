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
              button(text: "AC",buttonbgColor: operatorColor,tColor: orangeColor),
              button(text: "<-",buttonbgColor: operatorColor),
              button(text: "", buttonbgColor: Colors.transparent),
              button(text: "/",buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x",buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-",buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+",buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "%",buttonbgColor: operatorColor),
              button(text: "0"),
              button(text: ".",buttonbgColor: operatorColor),
              button(text: "=",buttonbgColor: orangeColor),
            ],
          )
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonbgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: buttonbgColor,
            padding: const EdgeInsets.all(22)),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: tColor, fontSize: 18),
        ),
      ),
    ));
  }
}
