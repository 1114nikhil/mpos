import 'package:mpos/features/auth/data/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<bool> execute(String username, String password) async {
    return await authRepository.signUpWithCredentials(username, password);
  }
}