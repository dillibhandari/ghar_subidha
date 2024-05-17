import 'package:ghar_subidha/core/database/database_helper.dart';
import 'package:ghar_subidha/core/helper/resultt/result.dart';
import 'package:ghar_subidha/feature/auth/data/model/register_model/register_model.dart';
import 'package:ghar_subidha/feature/auth/domain/usecase/auth_usecase.dart';

abstract class AuthLocalDataSource {
  Future<Result> registerUser(UserRegister userData);
  Future<Result> loginUser(SignInParam param);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final DbHelper _dbHelper;
  AuthLocalDataSourceImpl(this._dbHelper);
  @override
  Future<Result> registerUser(UserRegister userData) async {
    return await _dbHelper.registerUser(userData);
  }

  @override
  Future<Result> loginUser(SignInParam param) async {
    return await _dbHelper.loginUser(param);
  }
}
