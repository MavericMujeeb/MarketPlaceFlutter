import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/domain/repositories/dashboard_repository.dart';

class GetDashboardUseCase extends CompletableUseCase {
  final DashboardRepository _dashboardRepository;

  GetDashboardUseCase(this._dashboardRepository);

  @override
  Future<Stream<dynamic>> buildUseCaseStream(params) async {
    final StreamController<dynamic> controller = StreamController();
    try {
      var result = await _dashboardRepository.fetchProducts();
      controller.add(result);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}