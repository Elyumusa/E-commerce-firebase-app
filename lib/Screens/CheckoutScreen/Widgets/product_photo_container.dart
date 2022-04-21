import 'package:flutter/material.dart';

class ProductPhotoContainer extends StatelessWidget {
  final String image;
  const ProductPhotoContainer({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(5),
      //margin: EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xFFF5F6F9)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage(
              image /*widget.mapOfProduct['product'].get('images')[0]*/),
        ),
      ),
    );
  }
}
