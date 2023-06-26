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
  bool isScientific = false;

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
    } else if (value == 'xⁿ') {
      input = "$input^";
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = userInput.replaceAll("×", "*");
        userInput = userInput.replaceAll("÷", "/");
        userInput = userInput.replaceAll("%", "/100");
        userInput = userInput.replaceAll("π", "3.1415926535897932");
        userInput = userInput.replaceAll("e", "e^1");
        userInput = userInput.replaceAll("√", "sqrt");
        userInput = userInput.replaceAll("sin-1", "arcsin");
        userInput = userInput.replaceAll("cos-1", "arccos");
        userInput = userInput.replaceAll("tan-1", "arctan");
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
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                colors: [Color(0xff434343), Color(0xff000000)])),
        child: Column(
          children: [
            //i/p o/p area
            Expanded(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(color: Colors.white, fontSize: 48),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: outputSize),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            )),
            //buttons
            isScientific ? scientificKeyboard() : keyboard(),
          ],
        ),
      ),
    );
  }

  Widget button(
      {text,
      tColor = Colors.white,
      buttonbgColor = buttonColor,
      fontSize = 18.0}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: buttonbgColor,
            padding: const EdgeInsets.all(15)),
        onPressed: () => onButtonClick(text),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: tColor, fontSize: fontSize),
        ),
      ),
    ));
  }

  Widget keyboard() {
    return Column(
      children: [
        Row(
          children: [
            button(
                text: "AC", buttonbgColor: operatorColor, tColor: orangeColor),
            button(text: "⌫", buttonbgColor: operatorColor),
            button(text: "%", buttonbgColor: operatorColor),
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
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor:
                              isScientific ? orangeColor : operatorColor,
                          padding: const EdgeInsets.all(12)),
                      onPressed: () {
                        isScientific = !isScientific;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.change_circle,
                        size: 35,
                      ))),
            ),
            button(text: "0"),
            button(text: ".", buttonbgColor: operatorColor),
            button(text: "=", buttonbgColor: orangeColor),
          ],
        )
      ],
    );
  }

  Widget scientificKeyboard() {
    return Column(
      children: [
        Row(
          children: [
            button(text: "log", buttonbgColor: operatorColor, fontSize: 16.0),
            button(text: "ln", buttonbgColor: operatorColor, fontSize: 16.0),
            button(text: "sin-1", buttonbgColor: operatorColor, fontSize: 10.0),
            button(text: "cos-1", buttonbgColor: operatorColor, fontSize: 10.0),
            button(text: "tan-1", buttonbgColor: operatorColor, fontSize: 10.0),
          ],
        ),
        Row(
          children: [
            button(text: "(", buttonbgColor: operatorColor),
            button(text: ")", buttonbgColor: operatorColor),
            button(text: "sin", buttonbgColor: operatorColor, fontSize: 16.0),
            button(text: "cos", buttonbgColor: operatorColor, fontSize: 16.0),
            button(text: "tan", buttonbgColor: operatorColor, fontSize: 16.0),
          ],
        ),
        Row(
          children: [
            button(text: "e", buttonbgColor: operatorColor),
            button(
                text: "AC", buttonbgColor: operatorColor, tColor: orangeColor),
            button(text: "⌫", buttonbgColor: operatorColor),
            button(text: "%", buttonbgColor: operatorColor),
            button(text: "÷", buttonbgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            button(text: "xⁿ", buttonbgColor: operatorColor, fontSize: 12.0),
            button(text: "7"),
            button(text: "8"),
            button(text: "9"),
            button(text: "×", buttonbgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            button(text: "√", buttonbgColor: operatorColor),
            button(text: "4"),
            button(text: "5"),
            button(text: "6"),
            button(text: "-", buttonbgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            button(text: "π", buttonbgColor: operatorColor),
            button(text: "1"),
            button(text: "2"),
            button(text: "3"),
            button(text: "+", buttonbgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor:
                              isScientific ? orangeColor : operatorColor,
                          padding: const EdgeInsets.all(12)),
                      onPressed: () {
                        isScientific = !isScientific;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.change_circle,
                        size: 30,
                      ))),
            ),
            button(text: ",", buttonbgColor: operatorColor),
            button(text: "0"),
            button(text: ".", buttonbgColor: operatorColor),
            button(text: "=", buttonbgColor: orangeColor),
          ],
        )
      ],
    );
  }
}
