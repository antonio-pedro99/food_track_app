import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:rxdart/rxdart.dart';

class FoodSearchService {
  final RestAPIWrapper api;
  //output stream
  late Stream<List<Food>?> _outputStream;
  //input stream

  final _inputStream = BehaviorSubject<String>();

  FoodSearchService({required this.api}) {
    _outputStream = _inputStream
        .debounce(
            (event) => TimerStream(true, const Duration(milliseconds: 1000)))
        .switchMap((name) async* {
      yield await api.fetchFoodDetailsUsingDishNames(name);
    });
  }

  void searchFood(String name) => _inputStream.add(name);

  Stream<List<Food>?> get results => _outputStream;
  void dispose() {
    _inputStream.close();
  }
}
