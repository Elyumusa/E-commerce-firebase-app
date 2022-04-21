import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  final int index;
  final TabController? controller;
  const PageIndicator({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
    int? index;
   TabController? controller;
  @override
  void initState() {
    // TODO: implement initState
    widget.controller?.addListener(() {
      setState(() {});
    });
     index=widget.index ;
     controller=widget.controller;
    super.initState();
  }
@override
  void didUpdateWidget(covariant PageIndicator oldWidget) {
    // TODO: implement didUpdateWidget
    index=widget.index ;
    
    controller=widget.controller;
    super.didUpdateWidget(oldWidget);
    
  }
@override
  void dispose() {
    // TODO: implement dispose
     widget.controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(bottom: 8),
      height: 5,
      width: controller?.index == index ? 15 : 5,
      decoration: BoxDecoration(
          color: controller?.index == index
              ? Colors.green
              : Colors.grey),
    );
  }
}
