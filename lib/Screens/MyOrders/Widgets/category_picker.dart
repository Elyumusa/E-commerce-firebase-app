import 'package:flutter/material.dart';

class CategoryPicker extends StatefulWidget {
  List<String> tabItems = ['All', 'Shirts', 'Jewerly', 'Hoodies', 'Cosmetics'];
  Function whenTabChanges;
  bool usedInMyOrders = false;
  CategoryPicker(
      {required this.tabItems,
      required this.whenTabChanges,
      required this.usedInMyOrders});
  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<String>? tabItems;
  int currentTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: widget.tabItems.length, vsync: this);
    controller!.addListener(handleTabChanges);
    super.initState();
  }

  void handleTabChanges() {
    if (controller!.indexIsChanging) return;
    widget.whenTabChanges(controller!.index);
    setState(() {
      currentTab = controller!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.usedInMyOrders == true
        ? TabBar(
            tabs: widget.tabItems
                .map((stringFromTab) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12),
                        decoration: widget.tabItems[currentTab] == stringFromTab
                            ? BoxDecoration(color: Colors.white)
                            : BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white),
                        child: widget.tabItems[currentTab] == stringFromTab
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_sharp,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    stringFromTab,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                stringFromTab,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ))
                .toList(),
            indicatorColor: Colors.transparent,
            //labelColor: Colors.green,
            isScrollable: true,
            //unselectedLabelColor: Colors.transparent,
            controller: controller,
          )
        : TabBar(
            tabs: widget.tabItems
                .map((stringFromTab) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        stringFromTab,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ))
                .toList(),
            indicatorColor: Colors.black,
            //labelColor: Colors.green,
            isScrollable: true,
            //unselectedLabelColor: Colors.transparent,
            controller: controller,
          );
  }
}
