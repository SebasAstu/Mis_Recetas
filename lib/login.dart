import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> authenticateUser(String email, String password) async {
    // Lógica de autenticación aquí, por ejemplo:
    if (email == "pruebagg@gmail.com" && password == "123456") {
      return true; // Autenticación exitosa
    } else if (email == "pgg2@gmail.com" && password == "654321") {
      return true; // Autenticación exitosa
    } else {
      return false; // Autenticación fallida
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person,
              color: Color(0xFFFFA53D),
              size: 50.0,
            ),
            SizedBox(height: 20.0),
            // Campo de correo
            Container(
              width: 250.0,
              height: 46.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color.fromARGB(255, 224, 224, 224),
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.mail, color: Color(0xFFFFA53D)),
                    hintText: 'Correo Electrónico',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Color(0xFFFFA53D)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Campo de contraseña
            Container(
              width: 250.0,
              height: 46.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color.fromARGB(255, 224, 224, 224),
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: Color(0xFFFFA53D)),
                    hintText: 'Contraseña',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Color(0xFFFFA53D)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text;
                String password = _passwordController.text;

                bool isAuthenticated = await authenticateUser(email, password);

                if (isAuthenticated) {
                  // Acción al iniciar sesión exitosamente
                  showSnackBar(context, "Inicio de sesión exitoso");
                } else {
                  // Acción en caso de falla de inicio de sesión
                  showSnackBar(context, "Inicio de sesión fallido");
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFFA53D),
                side: BorderSide(
                  color: Color(0xFFFFA53D),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Container(
                width: 131.0,
                height: 46.0,
                child: Center(
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // ¿Olvidaste tu contraseña? (presionable)
            GestureDetector(
              onTap: () {
                // Acción al presionar el enlace de "Olvidaste tu contraseña?"
              },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            // ¿No tienes cuenta? Regístrate (presionable)
            GestureDetector(
              onTap: () {
                // Acción al presionar el enlace de "¿No tienes cuenta? Regístrate"
              },
              child: Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
