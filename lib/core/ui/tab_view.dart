import 'package:cdcalctest/core/ui/prifile_tab.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabViewState();
  }
}

class TabViewState extends State<TabView> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.animateTo(1);
    tabController.addListener(() {
      if (tabController.index == 0) {
        Navigator.pop(context);
        tabController.index = 1;

      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: getTabBar(),
        ),
      ),
      body: getTabBarPages(),
    );
  }

  Widget getTabBar() {
    return TabBar(
      controller: tabController,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.directions_car)),
        Tab(icon: Icon(Icons.email)),
        Tab(icon: Icon(Icons.filter_hdr)),
        Tab(icon: Icon(Icons.account_box))
      ],
    );
  }

  Widget getTabBarPages() {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        Container(),
        Container(
          child: Center(
            child: Text("Tab 2"),
          ),
        ),
        Container(
          child: Center(
            child: Text("Tab 3"),
          ),
        ),
        Container(
          child: PrifileTab(),
        ),
      ],
    );
  }
}
