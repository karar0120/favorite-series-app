
import 'package:flutter/material.dart';
import 'package:imdb/Constants/My_Colors.dart';
import 'package:imdb/data/models/Characters.dart';

import '../../Constants/String_Constants.dart';

class CharacterItem extends StatelessWidget {
  final characters Characters;

  const CharacterItem({Key? key ,required this.Characters}) : super(key: key);

  //const CharacterItem({Key? key,required this.characters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColor.Mywhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, CharactersDetailsScreen,arguments: Characters);
        },
        child: GridTile(
          child: Hero(
            tag:Characters.charId,
            child: Container(
             color: MyColor.MyGrey,
             child: Characters.img.isNotEmpty?FadeInImage.assetNetwork(
               width: double.infinity,
                 height: double.infinity,
                 fit: BoxFit.cover,
                 placeholder:"assets/images/Loading.gif",
                 image:'${Characters.img}'
             ):Image.asset("assets/images/error.gif"),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15
            ),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text("${Characters.name}",style: TextStyle(
              height: 1.5,
              color: MyColor.Mywhite,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            ),
          ),
        ),
      ),
    );
  }
}
