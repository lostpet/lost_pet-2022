
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/login_controller.dart';
import '../../controller/request/login_request.dart';
import 'gestion_mascota.dart';
import 'register.dart';


class LoginPage extends StatelessWidget {
  final _pref = SharedPreferences.getInstance();

  final _imageUrl = "assets/login.png";
  late LoginController _controller;
  late LoginRequest _request;

  LoginPage({super.key}) {
    _controller = LoginController();
    _request = LoginRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _logo(),
              _formulario(context),
              _inicioAlternativo(),
              TextButton(
                child: const Text("No tiene usuario, Registrate aqui"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset(_imageUrl),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _formulario(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          _campoCorreoElectronico(),
          const SizedBox(height: 8),
          _campoClave(),
          const SizedBox(height: 20),
          _iniciarSesion(context, formKey),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _campoCorreoElectronico() {
    return TextFormField(
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Correo Electrónico',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "El correo electronico es obligatorio";
        }
        if (!value.contains("@") || !value.contains(".")) {
          return "El correo tiene un formato inválido";
        }
        return null;
      },
      onSaved: (value) {
        _request.email = value!;
      },
    );
  }

  Widget _campoClave() {
    return TextFormField(
      maxLength: 30,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Contraseña',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "La contraseña es obligatoria";
        }
        if (value.length < 6) {
          return "Minimo debe contener 6 caracteres";
        }
        return null;
      },
      onSaved: (value) {
        _request.password = value!;
      },
    );
  }

  Widget _inicioAlternativo() {
    return Column(
      children: [
        const Text("O iniciar sesion con"),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text("Facebook"),
              onPressed: () {},
            ),
            ElevatedButton(
              child: const Text("Google"),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _iniciarSesion(BuildContext context, GlobalKey<FormState> formKey) {
    return ElevatedButton(
      child: const Text(
        "Iniciar sesion",
        style: TextStyle(fontSize: 24),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();

          // Validar correo y clave en BD
          try {
            final nav = Navigator.of(context);

            var userInfo = await _controller.validateEmailPassword(_request);

            var pref = await _pref;
            pref.setString("uid", userInfo.id!);
            pref.setString("name", userInfo.name!);
            pref.setString("email", userInfo.email!);
            pref.setBool("admin", userInfo.isAdmin!);

            nav.pushReplacement(MaterialPageRoute(
              builder: (context) => const GestionMascota(),
            ));
          } catch (e) {
            // showDialog(
            //   context: context,
            //   builder: (context) => AlertDialog(
            //     title: const Text("Ventas"),
            //     content: Text(e.toString()),
            //   ),
            // );

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }
      },
    );
  }
}

