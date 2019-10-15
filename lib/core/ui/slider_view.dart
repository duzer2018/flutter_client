import 'package:flutter_client/core/blocs/bloc_slider.dart';
import 'package:flutter_client/core/ui/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SliderView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SliderViewState();
  }
}

class SliderViewState extends State<SliderView> {
  final sliderBloc = SliderBloc();
  PanelController controller = new PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Уютное гнездышко"),),
        body: SlidingUpPanel(
      collapsed: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60)))),
      controller: controller,
      borderRadius: BorderRadiusGeometry.lerp(
          BorderRadius.only(
              topLeft: Radius.circular(60), topRight: Radius.circular(60)),
          BorderRadius.only(topRight: Radius.circular(20)),
          0),
      panel: Center(
        child: Text("data"),
      ),
      onPanelOpened: () {
        controller.close();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TabView()));
      },
    ));
  }
}
