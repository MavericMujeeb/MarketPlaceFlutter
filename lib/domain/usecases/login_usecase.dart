import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/domain/repositories/authentication_repository.dart';

class GetLoginUseCase extends CompletableUseCase<LoginUseCaseParams> {
  final AuthenticationRepository _authenticationRepository;

  GetLoginUseCase(this._authenticationRepository);

  @override
  Future<Stream<dynamic>> buildUseCaseStream(params) async {
    final StreamController<dynamic> controller = StreamController();
    try {
      if (params != null &&
          params.username.isNotEmpty &&
          params.password.isNotEmpty) {
        var result = await _authenticationRepository.loginUser(
            params.username, params.password);
        controller.add(result);
      }

      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class LoginUseCaseParams {
  final String username;
  final String password;
  LoginUseCaseParams(
    this.username,
    this.password,
  );
}
