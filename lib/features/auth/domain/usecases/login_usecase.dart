import 'package:mpos/features/auth/data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<bool> execute(String username, String password) async {
    return await authRepository.loginWithCredentials(username, password);
  }

  Future<bool> executeWithGoogle() async {
    var user = await authRepository.loginWithGoogle();
    return user != null;
  }
}