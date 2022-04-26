import 'package:imdb/data/models/Characters.dart';
import 'package:imdb/data/models/qutoes.dart';

abstract class CharactersState {}

class Characterinitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<characters> character;

  CharactersLoaded(this.character);
}
 class SearchCharacters extends CharactersState{}
 class SearchCharactersisclose extends CharactersState{}
 class SearchCharactersisstart extends CharactersState{}
// class SearchCharactersClearSearch extends CharactersState{}

class QuotesLoaded extends CharactersState {
  final List<Quotes> quotes;
  QuotesLoaded(this.quotes);
}