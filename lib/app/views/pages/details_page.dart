import 'package:flutter/material.dart';

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
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight),
                  child: Column(
                    children: const [Text("Antonio Pedro"), Text(" Pedro")],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
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
