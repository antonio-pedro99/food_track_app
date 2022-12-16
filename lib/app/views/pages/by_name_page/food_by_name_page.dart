import 'package:flutter/material.dart';
import 'package:food_track_app/app/blocs/foods_bloc.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/providers/bloc_provider.dart';
import 'package:food_track_app/app/views/pages/details_page/details_page.dart';
import 'package:food_track_app/app/views/widgets/food_tile.dart';
import 'package:food_track_app/app/views/widgets/text_field.dart';

class FoodByNamePage extends StatefulWidget {
  const FoodByNamePage({super.key, required this.title});

  final String title;

  @override
  State<FoodByNamePage> createState() => _FoodByNamePageState();
}

class _FoodByNamePageState extends State<FoodByNamePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: FoodByNameListBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(onPressed: () => {}, icon: const Icon(Icons.notes))
          ],
        ),
        body: const FoodListScreen(),
      ),
    );
  }
}

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final TextEditingController searchEditingController = TextEditingController();
  var foodsResult = [];

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<FoodByNameListBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: <Widget>[
          CustomTextField(
            controller: searchEditingController,
            hint: "Type the name of the Food",
            icon: Icons.search,
            onEnter: bloc.searchQuery.add,
          ),
          const SizedBox(height: 24),
          Flexible(child: _buildResults(bloc))
        ],
      ),
    );
  }
}

Widget _buildResults(FoodByNameListBloc bloc) {
  return StreamBuilder<List<Food>?>(
    stream: bloc.foodsStreams,
    builder: (context, snapshot) {
      // 2
      final results = snapshot.data;
      if (results == null) {
        return const Center(child: CircularProgressIndicator());
      } else if (results.isEmpty) {
        return const Center(child: Text('No Results'));
      }

      return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => FoodDetailsPage(
                        food: results[index],
                        tag: "${results[index].foodId}$index",
                        title: "Food Details")),
              ),
              child: Hero(
                  tag: "${results[index].foodId}$index",
                  child: FoodTile(
                    food: results[index],
                  )),
            );
          });
    },
  );
}
