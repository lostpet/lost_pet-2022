
import 'package:flutter/material.dart';

import 'loguear.dart';
import 'principal.dart';

class mascotas_rescatadas extends StatelessWidget {
  const mascotas_rescatadas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mascotas Rescatadas")),
      //     body: Center(child: Image.network("https://i2.wp.com/www3.gobiernodecanarias.org/medusa/ecoblog/crodalf/files/2021/10/calabaza.jpg?fit=450%2C413&ssl=1",height: 200,width:100)
      body: Center(
        child: IconButton(
          icon: Icon(Icons.co_present_sharp),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const principal()),
            );
          },
          iconSize: 50,
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyLogin()),
          );


        }, child: Icon(Icons.add),),



    );
  }
}

