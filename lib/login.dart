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
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginInitialState) {
            return buildInitialUI(context);
          } else if (state is LoginLoadingState) {
            return buildLoadingUI();
          } else if (state is LoginSuccessState) {
            return buildSuccessUI(context);
          } else if (state is LoginFailureState) {
            return buildFailureUI(context);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildInitialUI(BuildContext context) {
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
                ),
                style: TextStyle(color: Color(0xFFFFA53D)),
              ),
            ),
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
              context.read<LoginCubit>().login(
                    _emailController.text,
                    _passwordController.text,
                  );
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

  Widget buildSuccessUI(BuildContext context) {
    Future.delayed(Duration(microseconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50.0,
          ),
          SizedBox(height: 20.0),
          Text("Exito"),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget buildFailureUI(BuildContext context) {
    Future.microtask(() {
      Future.delayed(Duration(microseconds: 20), () {
        // Este código se ejecuta después de 2 segundos
        context.read<LoginCubit>().reset(); // Reiniciar el estado del cubit
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      });
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.red,
            size: 50.0,
          ),
          SizedBox(height: 20.0),
          Text("Fallido"),
        ],
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
