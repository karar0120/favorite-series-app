import 'package:imdb/data/models/Characters.dart';
import 'package:imdb/data/models/qutoes.dart';

import '../web_service/Character_Web_Service.dart';

class CharacterRepository {
  CharacterWebService? characterWebService;

  CharacterRepository(this.characterWebService);

  Future<List<characters>> getAllCharacter() async {
    final character = await characterWebService?.getAllCharacter();
    return character!.map((element) => characters.fromJson(element)).toList();
  }

  Future<List<Quotes>> getAllQuotes(String charName) async {
    final Quote = await characterWebService!.getAllQuotes(charName);
    return Quote.map((element) =>Quotes.fromJson(element)).toList();
    //return character!.map((element) => characters.fromJson(element)).toList();
  }
}
