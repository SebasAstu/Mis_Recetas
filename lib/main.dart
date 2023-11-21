import 'package:flutter/material.dart';
import 'package:mis_recetas/sign_up_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas App'),
        backgroundColor: Colors.purple[200],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple[200],
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
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Recetas Destacadas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'data:image/jpeg;base64,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',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nombre del Platillo'),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star_half, color: Colors.yellow),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text('Ver Receta'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
