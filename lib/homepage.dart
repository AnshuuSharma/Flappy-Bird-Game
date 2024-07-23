import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled10/barrier.dart';
import 'package:untitled10/bird.dart';
class HomePage extends StatefulWidget {
   HomePage({Key?key}):super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdy=0;
  double initialpos=birdy;
  double height=0;
  double time=0;
  double gravity=-4.9;
  double velocity=2.6;
  bool gameHasStarted=false;

  static double xOne=1.2;
  double xTwo=xOne+2;
  static List<double> barrierX=[2,2+1.5];
  static double barrierWidth=0.5;
  List<List<double>>barrierHeight=[
    [0.6, 0.4],
    [0.4, 0.6]
  ];
  void startGame(){
    gameHasStarted=true;
    Timer.periodic(Duration(milliseconds:100), (timer) {
    height=gravity*time*time+velocity*time;
    setState(() {
      birdy=initialpos-height;
    });
    setState(() {
      if(xOne<-2.2){
        xOne+=3.5;
      }else{
        xOne-=0.05;
      }
    });setState(() {
      if(xTwo<-2.2){
        xTwo+=3.5;
      }else{
        xTwo-=0.05;
      }
    });
    if(isBirdDead()){
      timer.cancel();
      gameHasStarted=false;
      _showDialog();
    }
    time+=0.05;
  });
  }
  void jump(){
    setState(() {
      time=0;
      initialpos=birdy;
    });
  }
  bool isBirdDead(){
    if(birdy>1){
     return true;
    }
    return false;
  }
  void resetGame(){
    Navigator.pop(context);
    setState(() {
      gameHasStarted=false;
      time=0;
      initialpos=birdy;
    });
  }
  void _showDialog(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.redAccent,
        title: Center(
          child: Text('G A M E  O V E R',style: TextStyle(color: Colors.white),),
        ),
        actions: [
          GestureDetector(
            onTap: resetGame,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.red.shade50,
                child: Center(
                  child: Text('PLAY AGAIN'),
                ),
              ),
            ),
          )
        ],
      );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: gameHasStarted?jump:startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex:3,
                  child: Center(
                    child: Stack(
                      children: [
                       AnimatedContainer(
                         alignment: Alignment(0,birdy),
                         duration: Duration(milliseconds: 0),
                         color: Colors.blue,
                         child:MyBird(),
                       ),
                        Container(
                          alignment: Alignment(0,-0.5),
                          child: Text(
                            gameHasStarted?'':'T A P  T O  S T A R T',style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                          ),
                        ),
                        AnimatedContainer(
                            alignment: Alignment(xOne,1.1),
                            duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 200.0,
                        ),
                        ),AnimatedContainer(
                            alignment: Alignment(xOne,-1.1),
                            duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 150.0,
                        ),
                        ),AnimatedContainer(
                            alignment: Alignment(xTwo,1.1),
                            duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 100.0,
                        ),
                        ),AnimatedContainer(
                            alignment: Alignment(xTwo,-1.1),
                            duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 250.0,
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
            Container(height: 15,color: Colors.green,),
            Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Score',style: TextStyle(color: Colors.white,fontSize: 17),),
                          Text('0',style:TextStyle(color: Colors.white,fontSize: 14))],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('Best',style: TextStyle(color: Colors.white,fontSize: 17),),
                            Text('10',style: TextStyle(color: Colors.white,fontSize: 14),)]),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
