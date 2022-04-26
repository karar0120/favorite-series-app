import 'package:dio/dio.dart';
import 'package:imdb/Constants/String_Constants.dart';

class CharacterWebService {
  late Dio dio;

  CharacterWebService() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 20 * 1000,
        connectTimeout: 20 * 1000);
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacter() async {
    try {
      Response response = await dio.get("characters");
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getAllQuotes(String charName) async {
    try {
      Response response = await dio.get("quote",queryParameters: {'author':charName});
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
