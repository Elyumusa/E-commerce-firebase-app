import 'dart:async';

import 'package:eligere/Screens/HomeScreen/Widgets/page_indicator.dart';
import 'package:flutter/material.dart';

import '../../../media_query.dart';

class Banners extends StatefulWidget {
  const Banners({
    Key? key,
    required this.banners,
    required TabController? tabcontroller,
  })  : _tabcontroller = tabcontroller,
        super(key: key);

  final List<Widget> banners;
  final TabController? _tabcontroller;

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MQuery.height! * 0.3,
        child: Stack(children: [
          TabBarView(
              children: widget.banners, controller: widget._tabcontroller),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: 30,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(widget.banners.length, (index) {
                        return PageIndicator(
                            index: index, controller: widget._tabcontroller);
                      }))))
        ], fit: StackFit.expand));
  }
}
