import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/base/presenter/base_presenter.dart';
import 'package:marketplace/domain/usecases/dashboard_usecase.dart';

class DashboardPresenter extends BasePresenter {
  final GetDashboardUseCase _getDashboardUseCase;
  DashboardPresenter(super.repo) : _getDashboardUseCase = GetDashboardUseCase(repo);

  fetchProducts() => _getDashboardUseCase.execute(
      _DashboardObserver(this), null);

  @override
  void dispose() {
    super.dispose();
    _getDashboardUseCase.dispose();
  }
}

class _DashboardObserver implements Observer<void> {
  // The above presenter
  final DashboardPresenter _dashboardPresenter;

  _DashboardObserver(this._dashboardPresenter);

  @override
  void onNext(data) {
    if (_dashboardPresenter.dataOnNext != null) {
      _dashboardPresenter.dataOnNext!(data);
    }
  }

  @override
  void onComplete() {
    if (_dashboardPresenter.dataComplete != null) {
      _dashboardPresenter.dataComplete!();
    }
  }

  @override
  void onError(e) {
    if (_dashboardPresenter.dataError != null) {
      _dashboardPresenter.dataError!(e);
    }
  }
}
