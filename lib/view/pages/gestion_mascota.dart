import 'package:flutter/material.dart';

class GestionMascota extends StatelessWidget {
  const GestionMascota({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Lost Pet",
        home: Scaffold(
          appBar: AppBar (
            title: Text("Gestion Mascotas"),

          ),
        ),

    );

  }

}

