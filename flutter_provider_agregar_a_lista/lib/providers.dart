import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_provider_agregar_a_lista/entities/userdata.dart';
import 'package:flutter_provider_agregar_a_lista/entities/listofgames.dart';
import 'package:flutter_provider_agregar_a_lista/entities/selecteduser.dart';


final userdataProvider = StateProvider<List<Users>>((ref) => listaUsuarios);
final selecteduserProvider = StateProvider<List<Selected>>((ref) => selectedlist);

final listaJuegosProvider = StateProvider<List<Games>>((ref) => listaJuegos);