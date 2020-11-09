import 'dart:async';
import 'package:discover_nepal/models/splash_event.dart';
import 'package:discover_nepal/models/splash_state.dart';

enum HomeViewState { Busy, DataRetrieved, NoData }

class SplashModel {
  final StreamController<SplashState> _stateController =
      StreamController<SplashState>();

  List<String> _listItems;

  //stream that broadcasts the home state
  Stream<SplashState> get splashState => _stateController.stream;

  void dispatch(SplashEvent event) {
    print('Event dispatched: $event');
    if (event is FetchData) {
      _getListData(hasData: event.hasData, hasError: event.hasError);
    }
  }

  Future _getListData({bool hasError = false, bool hasData = true}) async {
    _stateController.add(BusySplashState());
    await Future.delayed(Duration(seconds: 2));

    if (hasError) {
      return _stateController.addError('An error has occured');
    }
    if (!hasData) {
      return _stateController.add(DataFetchedSplashState(data: List<String>()));
    }
    _listItems = List<String>.generate(10, (index) => '$index title');
    _stateController.add(DataFetchedSplashState(data: _listItems));
  }
}
