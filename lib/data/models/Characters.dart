class characters {
 late int charId;
 late String name;
  String? birthday;
 late List<String> occupation;
 late String img;
  late String status;
  String? nickname;
  late List<int> appearance;
  late String portrayed;
  late String category;
  late List<dynamic> betterCallSaulAppearance;

  characters.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'].cast<String>();
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'].cast<int>();
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}
