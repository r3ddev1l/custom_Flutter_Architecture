class SplashState {}

class InitializedSplashState extends SplashState {}

class DataFetchedSplashState extends SplashState {
  final List<String> data;

  DataFetchedSplashState({this.data});

  bool get hasData => data.length > 0;
}

class ErrorSplashState extends SplashState {}

class BusySplashState extends SplashState {}
