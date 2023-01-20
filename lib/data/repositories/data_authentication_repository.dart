import 'package:marketplace/domain/entities/user_dao.dart';
import 'package:marketplace/domain/repositories/authentication_repository.dart';

class DataAuthenticationRepository implements AuthenticationRepository {
  DataAuthenticationRepository._privateConstructor();

  /// Singleton object of `DataAuthenticationRepository`
  static final DataAuthenticationRepository _instance =
      DataAuthenticationRepository._privateConstructor();

  factory DataAuthenticationRepository() => _instance;

  @override
  Future<UserDao> loginUser(String username, String password) async {
    return UserDao();
  }
}
