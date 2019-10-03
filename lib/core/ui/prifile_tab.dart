import 'package:flutter/material.dart';

class PrifileTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PrifileTabState();
  }
}

class PrifileTabState extends State<PrifileTab> {

  String name = "Tony Stark";

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 210,
              height: 220,
              child: Stack(children: <Widget>[
                
              Center(
                child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            )),
            Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.photo_camera),
                  onPressed: (){},
                )),
            ])),
            Container(width: 170, child: TextField(
              decoration: InputDecoration(
                hoverColor: Colors.white,
                fillColor: Colors.white,
                focusColor: Colors.white,
                hasFloatingPlaceholder: false,
                alignLabelWithHint: true,
                hintText: name
              ),
            )),
          ],
        )
      ])),
      // Positioned(
      //     top: 20,
      //     left: 20,
      //     child: Container(
      //       width: 150,
      //       height: 150,
      //       decoration: BoxDecoration(
      //         border: Border.all(width: 3, color: Colors.grey),
      //         borderRadius: BorderRadius.all(Radius.circular(30)),
      //       ),
      //     )),
      //     Positioned(
      //       top: 60,
      //       right: 20,
      //       child: Container(
      //         width: 200,
      //         child: TextField(
      //         )),
      //     )
    ]);
  }
}
