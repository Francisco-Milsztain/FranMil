class LoginState
{
  String estado_login = '';

  //constructor
  LoginState
  (
    {
      required this.estado_login, 
    }
  );
}

// Lista de usuarios (base de datos)
  List<LoginState> listaVariables =  //DatosUsuario es de donde se sacan las variables. listaUsuarios es el nombre de la lista
  [
    LoginState(estado_login: 'Ingresar datos', ),
  ];