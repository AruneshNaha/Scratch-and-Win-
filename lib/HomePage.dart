import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO: import images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");
  int counter = 5;
  int currentBox = 26;
  bool won = false;

  //TODO: get an array
  List<String> itemArray;
  int luckynumber;

  //TODO: initialize array with 25 elements
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckynumber = random;
    });
  }

  //TODO: define a getImage method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
      case "unlucky":
        return unlucky;
      default:
        return circle;
    }
  }

  //TODO: play game method
  playGame(int index) {
    if (luckynumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
  }

  //TODO: show all
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckynumber] = "lucky";
    });
  }

  //TODO: reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      this.counter = 5;
      currentBox = 26;
      won = false;
      debugPrint("Lucky Number: ${luckynumber}");
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and win!"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(20.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemCount: itemArray.length,
                  itemBuilder: (context, i) => SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            this.playGame(i);
                            this.currentBox = i;
                            this.counter = this.counter - 1;
                            if (i == luckynumber) {
                              showAll();
                              this.counter = 0;
                              this.won = true;
                            }
                            if (counter == 0 && !this.won) {
                              showAll();
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                resetGame();
                              });
                            }
                          },
                          child: Image(
                            image: this.getImage(i),
                          ),
                        ),
                      ))),
          Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.yellow[400],
              child: this.counter == 0 &&
                      this.currentBox != this.luckynumber &&
                      !this.won
                  ? Text("You lost!",
                      style: TextStyle(
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.center)
                  : (this.won)
                      ? Text(
                          "You won!",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "Scratches remaining: ${this.counter}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          textAlign: TextAlign.center,
                        )),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
                color: Colors.yellow,
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Show all",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  this.showAll();
                }),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
                color: Colors.yellow,
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Reset",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  this.resetGame();
                }),
          ),
          Container(
            margin: EdgeInsets.all(0.0),
            color: Colors.black,
            padding: EdgeInsets.all(4.0),
            child: Center(
              child: Text(
                "Naha's Codebase",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
