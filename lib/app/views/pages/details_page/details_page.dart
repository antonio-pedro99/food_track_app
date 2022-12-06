import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/details_page/carousel.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({super.key, required this.title});
  final String title;
  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.title),
            floating: true,
            expandedHeight: 300,
            flexibleSpace:   FlexibleSpaceBar(
              centerTitle: true,
              background: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: kToolbarHeight, left: 8, right: 8),
                  child: CustomCarouselSlider(itemCount: 2, items: [ Container(
                color: Colors.red,
                height: 200,
              ),
              Container(
                color: Colors.blue,
                height: 200,
              )]),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(const [
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro"),
            Text("Antonio Pedro"),
            Text(" Pedro")
          ]))
        ],
      ),
    );
  }
}
