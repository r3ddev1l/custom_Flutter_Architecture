import 'package:discover_nepal/models/splash_event.dart';
import 'package:discover_nepal/models/splash_model.dart';
import 'package:discover_nepal/models/splash_state.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final model = SplashModel();

  @override
  void initState() {
    model.dispatch(FetchData(hasData: true, hasError: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.dispatch(FetchData(hasError: false, hasData: true));
          },
        ),
        body: StreamBuilder(
          stream: model.splashState,
          builder: (buildContext, snapshot) {
            print(snapshot.data);

            if (snapshot.hasError) {
              return _getInformationMessage(snapshot.error);
            }

            var homeState = snapshot.data;

            if (!snapshot.hasData || homeState is BusySplashState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (homeState is DataFetchedSplashState) {
              if (!homeState.hasData)
                return _getInformationMessage('No data found');
            }
            return ListView.builder(
                itemCount: homeState.data.length,
                itemBuilder: (BuildContext context, index) =>
                    _getListItemUI(index, homeState.data));
          },
        ));
  }

  Widget _getListItemUI(int index, List<String> listItems) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[600], borderRadius: BorderRadius.circular(8)),
      child: Text(listItems[index]),
    );
  }

  Widget _getInformationMessage(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
