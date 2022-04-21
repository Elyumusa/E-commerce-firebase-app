import 'package:eligere/blocs/cart_bloc.dart';
import 'package:eligere/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../home.dart';

class NavBarItem extends StatefulWidget {
  const NavBarItem({
    Key? key,
    required this.onTabChanged,
    required this.tabItems,
    required this.currentIndex,
    required this.index,
  }) : super(key: key);

  final ValueChanged<int> onTabChanged;
  final List tabItems;
  final int currentIndex;
  final int index;

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 1,
      upperBound: 1.3);

  late CartBloc cartBloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cartBloc = MyHomePage.of(context).blocProvider.cartBloc;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        if (widget.index != widget.currentIndex) {
          widget.onTabChanged(widget.index);
          _controller.forward().then((value) => _controller.reverse());
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          widget.tabItems[widget.index]['title'] == 'Cart'
              ? cartandLengthWidget()
              : ScaleTransition(
                  scale: _controller,
                  child: SvgPicture.asset(widget.tabItems[widget.index]['icon'],
                      width: 25,
                      height: 25,
                      color: widget.index == widget.currentIndex
                          ? Colors.green
                          : Colors.black),
                ),
          Text(widget.tabItems[widget.index]['title'])
        ],
      ),
    );
  }

  Stack cartandLengthWidget() {
    return Stack(
      children: [
        ScaleTransition(
          scale: _controller,
          child: SvgPicture.asset(widget.tabItems[widget.index]['icon'],
              width: 25,
              height: 25,
              color: widget.index == widget.currentIndex
                  ? Colors.green
                  : Colors.black),
        ),
        Positioned(
            right: -1,
            top: -1,
            child: StreamBuilder<Object>(
                stream: cartBloc.updatedCart.stream,
                builder: (context, snapshot) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: kPrimaryColor),
                    child: Text('${cartBloc.cart.length}'),
                  );
                }))
      ],
    );
  }
}
