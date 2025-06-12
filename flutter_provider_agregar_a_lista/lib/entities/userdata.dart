class Users
{

  String email = '';
  String password = '';
  String nombre = '';
  String direccion = '';

  //constructor
  Users
  (
    {
      required this.email, 
      required this.password,
      required this.nombre,
      required this.direccion,
    }
  );
}

// Lista de usuarios (base de datos)
  List<Users> listaUsuarios =  //DatosUsuario es de donde se sacan las variables. listaUsuarios es el nombre de la lista
  [
    Users(email: 'francisco@gmail.com', password: '12345',  nombre: 'Francisco', direccion: 'ORT Yatay'),
    Users(email: 'javier@gmail.com',    password: '54321',  nombre: 'Javier',    direccion: 'ORT Belgrano'),
    Users(email: 'pedro@gmail.com',     password: 'abcde',  nombre: 'Pedro',     direccion: 'ORT Tigre'),
    Users(email: 'fabian@gmail.com',    password: 'edcba',  nombre: 'Fabian',    direccion: 'ORT Uruguay'),
    Users(email: 'tomas@gmail.com',     password: 'javier', nombre: 'Tomas',     direccion: 'ORT Polonia'),
  ];