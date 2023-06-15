import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //variables
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  //click function
  onButtonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
      hideInput = false;
      outputSize = 34;
    } else if (value == '⌫') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = userInput.replaceAll("×", "*");
        userInput = userInput.replaceAll("÷", "/");
        userInput=userInput.replaceAll("%", "/100");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //i/p o/p area
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? '' : input,
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: outputSize),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          )),
          //buttons
          Row(
            children: [
              button(
                  text: "AC",
                  buttonbgColor: operatorColor,
                  tColor: orangeColor),
              button(text: "⌫", buttonbgColor: operatorColor),
              button(text: "", buttonbgColor: Colors.transparent),
              button(text: "÷", buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "×", buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-", buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "%", buttonbgColor: operatorColor),
              button(text: "0"),
              button(text: ".", buttonbgColor: operatorColor),
              button(text: "=", buttonbgColor: orangeColor),
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
        onPressed: () => onButtonClick(text),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: tColor, fontSize: 18),
        ),
      ),
    ));
  }
}
