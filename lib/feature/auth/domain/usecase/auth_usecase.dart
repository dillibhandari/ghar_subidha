import 'package:dartz/dartz.dart';
import 'package:ghar_subidha/core/helper/error_handler/error_handler.dart';
import 'package:ghar_subidha/feature/auth/data/model/register_model/register_model.dart';
import 'package:ghar_subidha/feature/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCase(this._authRepository);
  Future<Either<AppException, bool>> signUp(SignUpParams params) async {
    UserRegister userData = UserRegister(
        fullname: params.fullName,
        email: params.email,
        address: params.address,
        password: params.password);
    return await _authRepository.userRegister(userData);
  }

  Future<Either<AppException, UserRegister>> loginUser(
      SignInParam params) async {
    return await _authRepository.loginUser(params);
  }
}

class SignUpParams {
  final String fullName;
  final String email;
  final String address;
  final String password;
  SignUpParams(this.fullName, this.address, this.password, this.email);
}

class SignInParam {
  final String email;
  final String password;

  SignInParam(this.email, this.password);
}

class BookingParam {
  final int userId;
  final int facId;
  final DateTime time;
  BookingParam(this.userId, this.facId, this.time);
}
