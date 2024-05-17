import 'package:dartz/dartz.dart';
import 'package:ghar_subidha/core/helper/error_handler/error_handler.dart';
import 'package:ghar_subidha/feature/auth/data/model/register_model/register_model.dart';
import 'package:ghar_subidha/feature/auth/domain/usecase/auth_usecase.dart';

abstract class AuthRepository {
  Future<Either<AppException, bool>> userRegister(UserRegister userRegister);
  Future<Either<AppException, UserRegister>> loginUser(SignInParam params);
}
