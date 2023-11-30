import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mis_recetas/RecipeDetails.dart';
import 'package:mis_recetas/login.dart';
import 'dart:convert';

import 'porfile.dart';

void main() {
  runApp(MyApp());
}

class Recipe {
  final String label;
  final String imageUrl;
  final String source;
  final double score;
  final String url;

  Recipe({
    required this.label,
    required this.imageUrl,
    required this.source,
    required this.score,
    required this.url,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.edamam.com/search?q=chicken&app_id=79acdb3b&app_key=6ec27f72236d11ef5c1820419c9ef05d&from=0&to=10&calories=591-722&health=alcohol-free'),
      );

      print('API Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          recipes = (data['hits'] as List)
              .map((hit) {
                final recipe = hit['recipe'];
                return Recipe(
                  label: recipe['label'],
                  imageUrl: recipe['image'],
                  source: recipe['source'],
                  score: recipe['yield'] * recipe['totalTime'],
                  url: recipe['url'],
                );
              })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      print('Error loading recipes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas App'),
        backgroundColor: Color(0xFFFFA53D),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        recipes[index].imageUrl,
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Image.asset('assets/imagen_reserva.jpg'); // Reemplaza 'imagen_reserva.jpg' con la ruta de tu imagen de reserva.
                        },
                      ),
                      ListTile(
                        title: Text(recipes[index].label),
                        subtitle: Text('Fuente: ${recipes[index].source}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Puntuación: ${recipes[index].score.toStringAsFixed(2)}'),
                            ElevatedButton(
                              onPressed: () {
                                // Implementa la onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipes[index])),
                                );                              
                              },
                              child: Text('Ver Más'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
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
