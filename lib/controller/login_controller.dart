import '../model/entity/user.dart';
import '../model/repository/fb_autentication.dart';
import '../model/repository/user_repository.dart';
import 'request/controller_register_request.dart';
import 'request/login_request.dart';
import 'response/controller_user_Info_response.dart';

class LoginController {
  late final UserRepository _userRepository;
  late final FirebaseAuthenticationRepository _authRepository;

  LoginController() {
    _userRepository = UserRepository();
    _authRepository = FirebaseAuthenticationRepository();
  }

  Future<UserInfoResponse> validateEmailPassword(LoginRequest request) async {
    await _authRepository.signInEmailPassword(request.email, request.password);

    // Consultar el usuario que tenga el correo dado
    var user = await _userRepository.findByEmail(request.email);

    return UserInfoResponse(
      id: user.id,
      email: user.email,
      name: user.name,
      isAdmin: user.isAdmin,
    );
  }

  Future<void> registerNewUser(RegisterRequest request,
      {bool adminUser = false}) async {
    // Consulto si el usuario ya existe
    try {
      await _userRepository.findByEmail(request.email);
      return Future.error("Ya existe un usuario con este correo electrónico");
    } catch (e) {
      // No existe el correo en la base de datos

      // Crear correo/clave en Firebase Authentication
      await _authRepository.createEmailPasswordAccount(
          request.email, request.password);

      // Agregar informacion adicional en base de datos
      _userRepository.save(UserEntity(
          email: request.email,
          name: request.name,
          address: request.address,
          phone: request.phone,
          isAdmin: adminUser));
    }
  }

  Future<void> logout() async {
    await _authRepository.signOut();
  }
}
