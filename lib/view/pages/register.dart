import 'package:flutter/material.dart';

import '../../controller/login_controller.dart';
import '../../controller/request/controller_register_request.dart';

class RegisterPage extends StatelessWidget {
  late RegisterRequest _data;
  late LoginController _controller;

  RegisterPage({super.key}) {
    _data = RegisterRequest();
    _controller = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _basicWidget(
                  "Nombre",
                  validarCampoObligatorio,
                      (newValue) {
                    _data.name = newValue!;
                  },
                ),
                _basicWidget(
                  "Direccion",
                  validarCampoObligatorio,
                      (newValue) {
                    _data.address = newValue!;
                  },
                ),
                _basicWidget(
                  "Correo Electrónico",
                  validarCampoObligatorio,
                      (newValue) {
                    _data.email = newValue!;
                  },
                ),
                _basicWidget(
                  "Telefono",
                      (value) => null,
                      (newValue) {
                    _data.phone = newValue;
                  },
                ),
                _basicWidget(
                  "Contraseña",
                  validarCampoObligatorio,
                      (newValue) {
                    _data.password = newValue!;
                  },
                  isPassword: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      try {
                        await _controller.registerNewUser(_data);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                              Text("Usuario registrado correctamente")),
                        );

                        Navigator.pop(context);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error.toString()),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Registrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validarCampoObligatorio(String? value) {
    if (value == null || value.isEmpty) {
      return "El campo es obligatorio";
    }
    return null;
  }

  Widget _basicWidget(String title, FormFieldValidator<String?> validate,
      FormFieldSetter<String?> save,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLength: 50,
        obscureText: isPassword,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: title,
        ),
        validator: validate,
        onSaved: save,
      ),
    );
  }
}
