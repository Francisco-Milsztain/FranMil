class DatosUsuario
{

  String email = '';
  String password = '';
  String nombre = '';
  String direccion = '';

  //constructor
  DatosUsuario
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
  List<DatosUsuario> listaUsuarios =  //DatosUsuario es de donde se sacan las variables. listaUsuarios es el nombre de la lista
  [
    DatosUsuario(email: 'francisco@gmail.com', password: '12345',  nombre: 'Francisco', direccion: 'ORT Yatay'),
    DatosUsuario(email: 'javier@gmail.com',    password: '54321',  nombre: 'Javier',    direccion: 'ORT Belgrano'),
    DatosUsuario(email: 'pedro@gmail.com',     password: 'abcde',  nombre: 'Pedro',     direccion: 'ORT Tigre'),
    DatosUsuario(email: 'fabian@gmail.com',    password: 'edcba',  nombre: 'Fabian',    direccion: 'ORT Uruguay'),
    DatosUsuario(email: 'tomas@gmail.com',     password: 'javier', nombre: 'Tomas',     direccion: 'ORT Polonia'),
  ];