import 'package:flutter/material.dart';
import 'package:mis_recetas/main.dart';
import 'RecipeDetails.dart';

class MisRecetasPage extends StatefulWidget {
  final List<Recipe> recipes;

  MisRecetasPage({required this.recipes});

  @override
  _MisRecetasPageState createState() => _MisRecetasPageState();
}

class _MisRecetasPageState extends State<MisRecetasPage> {
  @override
  Widget build(BuildContext context) {
    // Filtra las recetas guardadas
    List<Recipe> misRecetas = widget.recipes.where((recipe) => recipe.saved).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Recetas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFA53D),
      ),
      body: Center(
        child: misRecetas.isEmpty
            ? Text('No tienes recetas guardadas.')
            : ListView.builder(
                itemCount: misRecetas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Contenedor para la imagen
                        Center(
                          child: Image.network(
                            misRecetas[index].imageUrl,
                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                              return Image.asset('assets/imagen_reserva.jpg');
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(misRecetas[index].label),
                          subtitle: Text('Fuente: ${misRecetas[index].source}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Icono de guardar a la izquierda
                              IconButton(
                                icon: Icon(
                                  misRecetas[index].saved ? Icons.favorite : Icons.favorite_border,
                                  color: misRecetas[index].saved ? Color(0xFFFFA53D) : Colors.grey,
                                ),
                                onPressed: () {
                                  // Cambia el estado de guardado al hacer clic en el icono
                                  setState(() {
                                    misRecetas[index].saved = !misRecetas[index].saved;
                                  });
                                },
                              ),
                              // Botón "Ver Más" a la derecha
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecipeDetailPage(recipe: misRecetas[index]),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(
                                  'Ver Más',
                                  style: TextStyle(
                                    color: Color(0xFFFFA53D),
                                  ),
                                ),
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
    );
  }
}
