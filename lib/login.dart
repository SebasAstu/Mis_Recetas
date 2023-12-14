import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mis_recetas/main.dart';
import './login_cubit.dart';
import './login_state.dart';
import './sign_up_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> authenticateUser(String email, String password) async {
    // Lógica de autenticación aquí, por ejemplo:
    if (email == "pruebagg@gmail.com" && password == "123456") {
      return true; // Autenticación exitosa
    } else {
      return false; // Autenticación fallida
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginInitialState) {
            return buildInitialUI(context);
          } else if (state is LoginLoadingState) {
            return buildLoadingUI();
          } else if (state is LoginSuccessState) {
            // En caso de éxito, navegar a la página deseada directamente
            Future.delayed(Duration(microseconds: 5), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            });
            return Container(); // No mostrar nada aquí
          } else if (state is LoginFailureState) {
            return buildInitialUI(context, errorMessage: state.errorMessage);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildInitialUI(BuildContext context, {String? errorMessage}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.person,
            color: Color(0xFFFFA53D),
            size: 50.0,
          ),
          SizedBox(height: 20.0),
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
                  errorText: errorMessage != null && errorMessage.isNotEmpty
                      ? errorMessage
                      : null,
                ),
                style: TextStyle(color: Color(0xFFFFA53D)),
              ),
            ),
          ),
          SizedBox(height: 10.0),
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
                  errorText: errorMessage != null && errorMessage.isNotEmpty
                      ? errorMessage
                      : null,
                ),
                style: TextStyle(color: Color(0xFFFFA53D)),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              String email = _emailController.text.trim();
              String password = _passwordController.text.trim();

              if (email.isEmpty || password.isEmpty) {
                showSnackBar(context, 'Por favor, completa todos los campos.');
                return;
              }

              bool isAuthenticated = await authenticateUser(email, password);

              if (isAuthenticated) {
                // Autenticación exitosa
                context.read<LoginCubit>().login(email, password);
              } else {
                // Autenticación fallida
                showSnackBar(context, 'Correo electrónico o contraseña incorrectos.');
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
          GestureDetector(
            onTap: () {},
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '¿No tienes cuenta?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    ' Regístrate',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 20.0),
          Text("Verificando credenciales..."),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFFFA53D), // Color naranja
      ),
    );
  }
}
