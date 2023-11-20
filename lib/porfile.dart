import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final String name;
  final int age;
  final String address;
  final String email;
  final String bio;

  ProfilePage({
    required this.username,
    required this.name,
    required this.age,
    required this.address,
    required this.email,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple[200], // Color naranja llamativo
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.transparent, // Sin fondo de color
              backgroundImage: AssetImage('tu_ruta_de_imagen'), // Agrega tu imagen de fondo aquí
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purpleAccent, // Color del borde
                    width: 6, // Ancho del borde
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.purpleAccent, // Color del icono
                ),
              ),
            ),
            SizedBox(height: 30), // Espacio entre la imagen y los datos

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20), // Ajusta el espacio a tu preferencia
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nombre:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    Text(
                      '$name',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Edad:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    Text(
                      '$age',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Correo Electrónico:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    Text(
                      '$email',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30), // Espacio entre los datos y otros elementos
          ],
        ),
      ),
    );
  }
}
