import 'package:flutter/material.dart';

import 'loguear.dart';
import 'mascotas_rescatadas.dart';


class principal extends StatelessWidget {
  const principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lost Pet",
      home: Scaffold(
        appBar: AppBar (
          title: Text("Mascotas Perdidas"),
          actions: <Widget>[

            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Siguiente pagína',
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const mascotas_rescatadas()),
                );

              },
            ),
          ],
        ),
body:SingleChildScrollView(
    child: Column(



    ),
),

          floatingActionButton:
          FloatingActionButton(
          onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  LoginPage()),
    );


    }, child: Icon(Icons.add),),

      )

    );
  }
}









