class RegisterRequest {
  late String name;
  late String address;
  late String email;
  late String? phone;
  late String password;

  @override
  String toString() {
    return "$name, $address, $email, $phone, $password";
  }
}