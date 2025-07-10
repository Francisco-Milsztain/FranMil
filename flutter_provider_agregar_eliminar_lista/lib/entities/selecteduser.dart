class Selected
{

  String email = '';
  String password = '';
  String nombre = '';
  String direccion = '';

  //constructor
  Selected
  (
    {
      required this.email, 
      required this.password,
      required this.nombre,
      required this.direccion,
    }
  );
}

  List<Selected> selectedlist =  
  [
    Selected(email: 'emailplaceholder', password: 'passwordplaceholder',  nombre: 'nameplaceholder', direccion: 'adressplaceholder'),
  ];