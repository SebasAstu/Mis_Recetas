import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'RecipeDetails.dart';
import 'login.dart';
import 'login_cubit.dart';
import 'sign_up_cubit.dart';
import 'sign_up_page.dart';
import 'porfile.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
      ],
      child: LoginApp(),
    ),
  );
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
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
  List<Recipe> featuredRecipes = [];
  bool isLoading = true;
  bool isLoadingFeaturedRecipes = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
    fetchFeaturedRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.edamam.com/search?q=chicken&app_id=79acdb3b&app_key=6ec27f72236d11ef5c1820419c9ef05d&from=0&to=10&calories=591-722&health=alcohol-free'),
      );

      print('API Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          recipes = (data['hits'] as List).map((hit) {
            final recipe = hit['recipe'];
            return Recipe(
              label: recipe['label'],
              imageUrl: recipe['image'],
              source: recipe['source'],
              score: recipe['yield'] * recipe['totalTime'],
              url: recipe['url'],
            );
          }).toList();
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

  Future<void> fetchFeaturedRecipes() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.edamam.com/search?q=featured&app_id=79acdb3b&app_key=6ec27f72236d11ef5c1820419c9ef05d&from=0&to=5'),
      );

      print('API Response (Featured Recipes): ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          featuredRecipes = (data['hits'] as List).map((hit) {
            final recipe = hit['recipe'];
            return Recipe(
              label: recipe['label'],
              imageUrl: recipe['image'],
              source: recipe['source'],
              score: recipe['yield'] * recipe['totalTime'],
              url: recipe['url'],
            );
          }).toList();
          isLoadingFeaturedRecipes = false;
        });
      } else {
        throw Exception('Failed to load featured recipes');
      }
    } catch (e) {
      print('Error loading featured recipes: $e');
      setState(() {
        isLoadingFeaturedRecipes = false;
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
      body: Column(
        children: [
          
          isLoadingFeaturedRecipes
              ? Center(child: CircularProgressIndicator())
              : _buildFeaturedRecipesSection(),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center( 
                                child: Image.network(
                                  recipes[index].imageUrl,
                                  errorBuilder:
                                      (BuildContext context, Object error,
                                          StackTrace? stackTrace) {
                                    return Image.asset(
                                        'assets/imagen_reserva.jpg');
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text(recipes[index].label),
                                subtitle:
                                    Text('Fuente: ${recipes[index].source}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Puntuación: ${recipes[index].score.toStringAsFixed(2)}'),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RecipeDetailPage(
                                                    recipe: recipes[index]),
                                          ),
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
                  ),
                ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
         items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Mis recetas',
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
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    username: 'usuario1',
                    name: 'Juan',
                    age: 25,
                    address: 'Calle Principal, 123',
                    email: 'email',
                    bio: 'bio',
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildFeaturedRecipesSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recetas Destacadas',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredRecipes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(
                          recipe: featuredRecipes[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16.0),
                    width: 120.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            featuredRecipes[index].imageUrl,
                            width: 120.0,
                            height: 90.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          featuredRecipes[index].label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
