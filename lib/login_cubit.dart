import 'package:bloc/bloc.dart';
import './login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  void login(String email, String password) async {
    emit(LoginLoadingState());

    bool isAuthenticated = await authenticateUser(email, password);

    if (isAuthenticated) {
      emit(LoginSuccessState());
    } else {
      emit(LoginFailureState());
    }
  }

  void reset() {
    emit(LoginInitialState());
  }

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
}
