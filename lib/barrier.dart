import 'package:flutter/material.dart';
class Barrier extends StatelessWidget {
  // final barrierWidth;
  // final barrierHeight;
  // final barrierX;
  final size;
  // final bool isThisBottomBarrier;
   Barrier({this.size});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 100,
      height:size,
      decoration: BoxDecoration(
        color: Colors.green,
        border:Border.all(width: 5,color: Colors.green.shade700)
      ),
      // alignment: Alignment((2*barrierX+barrierWidth)/(2-barrierWidth),
      //     isThisBottomBarrier?1:-1),
      // child: Container(
      //   color: Colors.green.shade800,
      //   width: MediaQuery.of(context).size.width*barrierWidth/2,
      //   height:MediaQuery.of(context).size.height*3/4*barrierHeight/2 ,
      // ),
    );
  }
}
