import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = "";
  String instructions = "";
  int myNumber = Random().nextInt(100);
  // Widget _buildPopupDialog(BuildContext context) {
  //   return AlertDialog(
  //   );
  // }
  Widget _buildPopupDialog(BuildContext context) {
    instructions = "Good job! Round 2?";
    myNumber = Random().nextInt(100);
    return const AlertDialog(
      title: Text("Good guess"),
      content:
           Text(
            "Congratulations! You won!", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),
          ),
      actions: <Widget>[
        CloseButton(),
      ],

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Guess My Number")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text("I'm thinking of a number between 1 and 100",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
            ),
            SizedBox.fromSize(size:const Size(0, 20)),
            const Text("It's your turn to guess my number",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox.fromSize(size:const Size(0, 20)),
            Text(instructions,
              style: const TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            ElevatedCardExample(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Try a number!", style: TextStyle(fontSize: 35),),
                    TextField(
                      onChanged: (String input){
                          setState(() {
                            value = input;
                          });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          int? number = int.tryParse(value);
                          if(number == null) {
                            instructions = "Hmm, try harder";
                          }
                          else{
                            if (myNumber == number) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => _buildPopupDialog(context),
                              );
                            }
                            else{
                              if(myNumber > number){
                                instructions = "Try a bigger one";
                              }
                              else{
                                instructions = "Try a smaller one";
                              }
                            }
                          }
                        });
                      },
                      child: const Text("Guess!"),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ignore: must_be_immutable
class ElevatedCardExample extends StatelessWidget {
  Widget child;
  ElevatedCardExample({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: SizedBox(
          width: 400,
          height: 200,
          child: child,
        ),
      ),
    );
  }
}