import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/models/food_result.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodSearchService {
  final RestAPIWrapper api;
  //output stream
  late Stream<FoodSearchResult> _outputStream;
  //input stream

  final _inputStream = BehaviorSubject<String>();

  FoodSearchService({required this.api}) {
    _outputStream = _inputStream
        .debounce(
            (event) => TimerStream(true, const Duration(milliseconds: 500)))
        .switchMap((name) async* {
      yield await api.fetchFoodDetailsUsingDishNames(name);
    });
  }

  void searchFood(String name) => _inputStream.add(name);

  Stream<FoodSearchResult> get results => _outputStream;
  void dispose() {
    _inputStream.close();
  }
}
final searchServiceProvider = Provider<FoodSearchService>((ref) {
  final repository = ref.watch(searchRepositoryProvider);
  return FoodSearchService(api: repository);
});

final searchResultsProvider =
    StreamProvider.autoDispose<FoodSearchResult>((ref) {
  final service = ref.watch(searchServiceProvider);
  return service.results;
});

