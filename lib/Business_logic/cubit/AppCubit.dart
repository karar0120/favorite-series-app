
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb/Business_logic/cubit/App_State.dart';
import 'package:imdb/Constants/My_Colors.dart';
import 'package:imdb/data/models/Characters.dart';
import 'package:imdb/data/models/qutoes.dart';
import 'package:imdb/data/repository/Character_repository.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharacterRepository characterRepository;
//  static newscubit get(context)=>BlocProvider.of(context);
  static CharactersCubit get(context)=>BlocProvider.of(context);
  CharactersCubit(this.characterRepository) : super(Characterinitial());

  List<characters> Characters = [];

  List<characters> getAllCharacter() {
    characterRepository.getAllCharacter().then((character) {
      emit(CharactersLoaded(character));
      this.Characters = character;
    });
    return Characters;
  }
  List<Quotes>quotes=[];

  void getAllQuotees(String charName) {
    characterRepository.getAllQuotes(charName).then((quote) {
      emit(QuotesLoaded(quotes));
      //this.quotes=quote;
      //this.Characters = character;
    });
  }



   List<characters> SearchCharacterItme = [];
   bool isSearch = false;
   var SearchEditController=TextEditingController();

  void addSearchorItemtoSearchList(String searchCharacter) {
    SearchCharacterItme = Characters.where((character) =>
        character.name.toLowerCase().startsWith(searchCharacter)).toList();
    emit(SearchCharacters());
  }
   List<Widget>AppBarAction(context){
    if (isSearch){
      return [
        IconButton(
            onPressed: (){
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear,color: MyColor.MyGrey,))
      ];
    }
    else {
      return [
        IconButton(
            onPressed:_onStartSearch(context),
            icon:Icon(Icons.search,color: MyColor.MyGrey,))
      ];
    }
  }
   _onStartSearch(context){
    ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _onCloseSearch));
    isSearch=true;
    emit(SearchCharactersisstart());
  }
  void _onCloseSearch(){
    _clearSearch();
    isSearch=false;
    emit(SearchCharactersisclose());
  }
  _clearSearch(){
    SearchEditController.clear();
   //emit(SearchCharactersClearSearch());
  }



}
