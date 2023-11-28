import 'package:flutter/material.dart';
import 'package:mis_recetas/login.dart';
import 'package:mis_recetas/porfile.dart';

//https://api.edamam.com/search?q=chicken&app_id=79acdb3b&app_key=6ec27f72236d11ef5c1820419c9ef05d&from=0&to=10&calories=591-722&health=alcohol-free
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas App'),
        backgroundColor: Color(0xFFFFA53D), 
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFFA53D), 
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Inicio'),
              onTap: () {
       
                Navigator.pop(context); 
              },
            ),
            ListTile(
              title: Text('Mis Recetas'),
              onTap: () {
           
                Navigator.pop(context); 
              },
            ),
           
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Mis recentas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        backgroundColor: Color(0xFFFFA53D),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        onTap: (int index) {
          switch (index) {
            case 0:
              print('Presionado Inicio');
              break;
            case 1:
              print('Presionado Buscar');
              break;
            case 2:
              print('Presionado Perfil');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(
                  username: 'usuario1',
                  name: 'Juan',
                  age: 25,
                  address: 'Calle Principal, 123',
                  email: 'email',
                  bio: 'bio',
                ),),
              );
              break;
          }
        },
      ),
    );
  }
}
