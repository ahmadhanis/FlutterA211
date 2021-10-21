import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController numaEditingController = TextEditingController();
  TextEditingController numbEditingController = TextEditingController();
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Simple App"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Simple Calculator",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                      controller: numaEditingController,
                      decoration: InputDecoration(
                          hintText: 'First number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      keyboardType: const TextInputType.numberWithOptions()),
                  const SizedBox(height: 20,),
                  TextField(
                      controller: numbEditingController,
                      decoration: InputDecoration(
                          hintText: 'Second number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      keyboardType: const TextInputType.numberWithOptions()),
                      const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => {_pressMe("+")},
                        child: const Text("+"),
                      ),
                      ElevatedButton(
                        onPressed: () => {_pressMe("-")},
                        child: const Text("-"),
                      ),
                      ElevatedButton(
                        onPressed: () => {_pressMe("x")},
                        child: const Text("*"),
                      ),
                      ElevatedButton(
                        onPressed: () => {_pressMe("/")},
                        child: const Text("/"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text("Result " + result.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 40))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pressMe(String op) {
    setState(() {
      double numa = double.parse(numaEditingController.text);
      double numb = double.parse(numbEditingController.text);
      switch (op) {
        case "+":
          result = numa + numb;
          return;
        case "-":
          result = numa - numb;
          return;
        case "x":
          result = numa * numb;
          return;
        case "/":
          result = numa / numb;
          return;
      }
    });
  }
}
