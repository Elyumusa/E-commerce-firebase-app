import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:flutter/material.dart';

class CarouselAndCategoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FutureBuilder<DocumentSnapshot<Object?>>(
            future: Database().products.doc('carousel').get(),
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return AlertDialog(
                  content: Text('Errrroor'),
                );
              }

              // Otherwise, show something whilst waiting for initialization to complete
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                List images = snapshot.data?.get('products');
                return CarouselSlider(
                    items: [
                      ...List.generate(
                        images.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          //height: 250,
                          // width: 220,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                  image: NetworkImage(
                                    images[index],
                                    scale: 0.2,
                                  ),
                                  height: 400,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover)),
                        ),
                      )
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 1.5,
                      //height: MediaQuery.of(context).size.width,
                      viewportFraction: 1.0,
                    ));
              }
              return CircularProgressIndicator();
            }),
        SizedBox(
          height: 10,
        ),
        Text('Categories'),
        SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
