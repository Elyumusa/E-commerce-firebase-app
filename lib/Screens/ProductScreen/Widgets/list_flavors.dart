import 'package:flutter/material.dart';

import '../../../constants.dart';

class ListFlavors extends StatefulWidget {
  final List flavors;
  final List chosenFlavors;
  const ListFlavors({
    Key? key,
    required this.flavors,
    required this.chosenFlavors,
  }) : super(key: key);

  @override
  State<ListFlavors> createState() => _ListFlavorsState();
}

class _ListFlavorsState extends State<ListFlavors> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        itemCount: widget.flavors.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
        ),
        itemBuilder: (context, index) {
          return InkResponse(
            onTap: () {
              if (widget.chosenFlavors.contains(widget.flavors[index]))
                setState(() {
                  widget.chosenFlavors.remove(widget.flavors[index]);
                });
              else {
                setState(() {
                  widget.chosenFlavors.add(widget.flavors[index]);
                });
              }
            },
            child: Container(
                // height: 10,
                //margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.all(2),
                child: Center(
                    child: Text(
                  widget.flavors[index],
                  style: TextStyle(
                      color:
                          widget.chosenFlavors.contains(widget.flavors[index])
                              ? Colors.white
                              : Colors.black),
                )),
                decoration: BoxDecoration(
                    color: widget.chosenFlavors.contains(widget.flavors[index])
                        ? kPrimaryColor
                        : null,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20))),
          );
        },
      ),
    );
  }
}
