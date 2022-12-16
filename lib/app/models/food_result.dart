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