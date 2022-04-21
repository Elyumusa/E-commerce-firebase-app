import 'package:eligere/Screens/HomeScreen/Widgets/carousel.dart';
import 'package:eligere/Screens/HomeScreen/Widgets/search_field.dart';
import 'package:eligere/Screens/SeeAllScreen/see_all.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/constants.dart';
import 'package:eligere/media_query.dart';
import 'package:eligere/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Widgets/banners.dart';
import 'Widgets/best_selling.dart';
import 'Widgets/exclusive_offers.dart';
import 'Widgets/featured.dart';
import 'Widgets/grocery_lists.dart';
import 'Widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabcontroller;
  List<Widget> banners = List.generate(3, (index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Image.asset(
        'assets/images/groceries-image.png',
        fit: BoxFit.fill,
      ),
    );
  });

  @override
  void initState() {
    // TODO: implement initState
    _tabcontroller = TabController(length: banners.length, vsync: this);
    print('Rn we in home');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabcontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MQuery().init(context);
    return SafeArea(
        child: FutureBuilder(
            future: Database().products.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return const AlertDialog(
                  content: Text('Errrroor'),
                );
              }

              // Otherwise, show something whilst waiting for initialization to complete
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SvgPicture.asset(
                                'assets/icons/groceries.svg',
                                height: 70),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Eligere Enterprise',
                            style: kTitleStyle.copyWith(
                                fontSize: 25, fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 5),
                          const SearchField(),
                          const SizedBox(height: 5),
                          CarouselAndCategoryHeader(),
                          const SizedBox(height: 5),
                          _buildSectionTitle('Exclusive Offers', () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SeeAllScreen(category: 'exclusiveOffers'),
                            ));
                          }),
                          const SizedBox(height: 10),
                          ExclusiveOffers(),
                          const SizedBox(height: 10),
                          _buildSectionTitle('Best Selling', () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SeeAllScreen(category: 'bestSelling'),
                            ));
                          }),
                          const SizedBox(height: 10),
                          BestSelling(),
                          const SizedBox(height: 10),
                          _buildSectionTitle('Grocery Lists', () {}),
                          const SizedBox(height: 10),
                          GorceryLists(),
                          const SizedBox(height: 10),
                          _buildSectionTitle('Featured Products', () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SeeAllScreen(category: 'allProducts'),
                            ));
                          }),
                          const SizedBox(height: 10),
                          FeaturedProducts(),
                        ],
                      ),
                    ));
              }
              return CircularProgressIndicator();
            }));
  }

  Padding _buildSectionTitle(String title, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(children: [
        Text(title, style: kTitleStyle.copyWith(fontSize: 18)),
        Spacer(),
        InkResponse(
          onTap: onTap,
          child: Text('See All ',
              style: TextStyle(
                  // decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
        )
      ]),
    );
  }
}
