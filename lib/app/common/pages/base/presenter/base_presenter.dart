import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class BasePresenter extends Presenter {
  // Controller Callback functions
  Function? dataOnNext;
  Function? dataComplete;
  Function? dataError;

  BasePresenter(repo);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
