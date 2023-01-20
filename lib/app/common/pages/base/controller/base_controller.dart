import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/base/presenter/base_presenter.dart';

class BaseController extends Controller {
  BasePresenter _basePresenter;
  bool isButtonEnabled = false;
  bool isLoading = false;

  BaseController(repo) : _basePresenter = BasePresenter(repo);

  @override
  void initListeners() {
    _basePresenter.dataOnNext = dataOnNext;
    _basePresenter.dataComplete = dataComplete;
    _basePresenter.dataError = dataError;
  }

  showProgressBar() {
    isLoading = true;
    isButtonEnabled = false;
    refreshUI();
  }

  dismissProgressBar() {
    isLoading = false;
    isButtonEnabled = true;
    refreshUI();
  }

  refresh(){
    super.refreshUI();
  }

  dataOnNext(data) {
    debugPrint('BaseController _dataOnNext =====: ');
  }

  dataComplete() {
    debugPrint('BaseController _dataComplete =====:');
  }

  dataError(error) {
    debugPrint('BaseController _dataError =====: $error');
    dismissProgressBar();
  }
}
