import 'package:flutter/material.dart';
import 'package:mis_recetas/main.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Receta'),
        backgroundColor: Color(0xFFFFA53D),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe.imageUrl,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset('assets/imagen_reserva.jpg');
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Label: ${recipe.label}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Puntuación: ${recipe.score.toStringAsFixed(2)}'),
            SizedBox(height: 16.0),
            Text(
              'Detalles Nutricionales:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Calorías: ${recipe.calories.toStringAsFixed(2)}'),
            SizedBox(height: 8.0),
            Text('Etiquetas de Salud: ${recipe.healthLabels.join(', ')}'),
            SizedBox(height: 8.0),
            Text('Ingredientes:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.ingredients
                  .map((ingredient) => Text('- $ingredient'))
                  .toList(),
            ),
            SizedBox(height: 16.0),
            Text('Etiquetas de Dieta: ${recipe.dietLabels.join(', ')}'),
            SizedBox(height: 8.0),
            Text('Tipo de Cocina: ${recipe.cuisineType.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
