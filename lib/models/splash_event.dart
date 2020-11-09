class SplashEvent {}

class FetchData extends SplashEvent {
  final bool hasError;
  final bool hasData;
  FetchData({this.hasError, this.hasData});

  @override
  String toString() {
    return 'FetchData { hasError: $hasError, hasData: $hasData}';
  }
}
