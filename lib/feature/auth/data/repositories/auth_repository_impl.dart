import 'package:dartz/dartz.dart';
import 'package:ghar_subidha/core/helper/error_handler/error_handler.dart';
import 'package:ghar_subidha/feature/auth/data/datasource/auth_local_data_source.dart';
import 'package:ghar_subidha/feature/auth/data/model/register_model/register_model.dart';
import 'package:ghar_subidha/feature/auth/domain/repositories/auth_repository.dart';
import 'package:ghar_subidha/feature/auth/domain/usecase/auth_usecase.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource _authLocalDataSource;
  AuthRepositoryImpl(this._authLocalDataSource);
  @override
  Future<Either<AppException, UserRegister>> loginUser(
      SignInParam params) async {
    try {
      var response = await _authLocalDataSource.loginUser(params);
      if (response.isSuccess()) {
        var data = response.getValue();
        return Right(UserRegister.fromJson(data));
      } else {
        return Left(DefaultException(
            errorMessage: response.getErrorMsg(), statusCode: 1500));
      }
    } catch (e) {
      return Left(
        DefaultException(
            errorMessage: "something went wrong", statusCode: 1517),
      );
    }
  }

  @override
  Future<Either<AppException, bool>> userRegister(
      UserRegister userRegister) async {
    try {
      var response = await _authLocalDataSource.registerUser(userRegister);
      if (response.isSuccess()) {
        return const Right(true);
      } else {
        return Left(DefaultException(
            errorMessage: "something went wrong", statusCode: 1500));
      }
    } catch (e) {
      return Left(DefaultException(
          errorMessage: "something went wrong", statusCode: 1500));
    }
  }
}
