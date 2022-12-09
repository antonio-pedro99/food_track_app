import 'package:food_track_app/app/models/food_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_result.freezed.dart';

enum FoodAPIError { rateLimitExceeded, parseError, unknownError }

extension FoodAPIErrorMessage on FoodAPIError {
  String get message {
    switch (this) {
      case FoodAPIError.rateLimitExceeded:
        return 'Rate limit exceeded';
      case FoodAPIError.parseError:
        return 'Error reading data from the API';
      case FoodAPIError.unknownError:
      default:
        return 'Unknown error';
    }
  }
}

@freezed
class FoodSearchResult with _$FoodSearchResult {
  const factory FoodSearchResult(List<Food> foods) = Data;
  const factory FoodSearchResult.error(FoodAPIError error) = Error;
}
