import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb/Business_logic/cubit/AppCubit.dart';
import 'package:imdb/data/models/Characters.dart';
import 'package:imdb/data/repository/Character_repository.dart';
import 'package:imdb/data/web_service/Character_Web_Service.dart';
import '../Constants/String_Constants.dart';
import '../Presentation/screen/CharacterWithSeach.dart';
import '../Presentation/screen/Characters_Details_Screen.dart';
import '../Presentation/screen/Characters_Screen.dart';

class AppRouter {
  late CharactersCubit charactersCubit;
  late CharacterRepository characterRepository;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebService());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CharactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => charactersCubit,
                child: Characters_Screen()));
      case CharactersDetailsScreen:
        final character=settings.arguments as characters;
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (context)=>CharactersCubit(characterRepository),
            child: Characters_Details_Screen(Character:character,)));
    }
  }
}
