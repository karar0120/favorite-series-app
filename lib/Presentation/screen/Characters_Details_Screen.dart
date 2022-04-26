import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb/Business_logic/cubit/AppCubit.dart';
import 'package:imdb/Business_logic/cubit/App_State.dart';
import 'package:imdb/Constants/My_Colors.dart';
import 'package:imdb/data/models/Characters.dart';

class Characters_Details_Screen extends StatelessWidget {
  characters Character;

  Characters_Details_Screen({Key? key, required this.Character})
      : super(key: key);

  //const Characters_Details_Screen({Key? key,required this.Character}) : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.MyGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle:true,
        title: Text(Character.name, style: TextStyle(
          color: MyColor.Mywhite,
        ),),
        background: Hero(
          tag: Character.charId,
          child: Image.network(
            Character.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildcharacterInfo(String title,String value){
    return RichText(
      maxLines: 1,
        overflow:TextOverflow.ellipsis ,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyColor.Mywhite
              )
            ),
            TextSpan(
                text: value,
                style: TextStyle(
                    fontSize: 16,
                    color: MyColor.Mywhite
                )
            )
          ]
        )

    );
  }

  Widget buildDiveder(double endIndent){
    return Divider(
      height: 30,
      color: MyColor.MyYallow,
      endIndent:endIndent ,
      thickness: 2,
    );
  }

  Widget CheackIfQuotesAreLoading(CharactersState state){
     if(state is QuotesLoaded){
       return displayRandomQuotesorEmptyspace(state);

    }else {
     return buildCircleIndicator();
    }
  }

  Widget  displayRandomQuotesorEmptyspace(QuotesLoaded state){
    List Quotes=state.quotes;
    print ("sssssssssssssssssssssssss${Quotes.length}");

    if (Quotes.length!=0){
      int RandomQuotes=Random().nextInt(Quotes.length-2);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 20,
            color: MyColor.MyYallow,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColor.MyYallow,
                offset: Offset(0,0)
              )
            ]
          ),
          child:AnimatedTextKit(
            repeatForever: true,
             animatedTexts: [
               FlickerAnimatedText(Quotes[RandomQuotes].quote),
             ],
          ),
        ),
      );

    }else{
      return Container();

    }
  }
  Widget buildCircleIndicator(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(color: MyColor.MyYallow,),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getAllQuotees(Character.name);
    return Scaffold(
      backgroundColor: MyColor.MyGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildcharacterInfo('Jobs : ',Character.occupation.join(' / ')),
                          buildDiveder(280),
                          buildcharacterInfo('Appeared in : ',Character.category),
                          buildDiveder(225),
                          buildcharacterInfo('Seasons : ',Character.appearance.join(' / ' )),
                          buildDiveder(250),
                          buildcharacterInfo('States : ',Character.status),
                          buildDiveder(265),
                          Character.betterCallSaulAppearance.isEmpty?Container():buildcharacterInfo('betterCallSaulSeasons : ',Character.betterCallSaulAppearance.join(" / ")) ,
                          Character.betterCallSaulAppearance.isEmpty?Container():buildDiveder(150),
                          buildcharacterInfo('Actor/Actors  : ',Character.portrayed),
                          buildDiveder(225),
                          SizedBox(
                            height: 40,
                          ),
                        ],

                      ),
                    ),
                    SizedBox(
                      height: 400,
                    ),
                    BlocBuilder<CharactersCubit,CharactersState>(builder:(context,state){
                      return  CheackIfQuotesAreLoading(state);
                    })
                  ],
              ))
        ],
      ),

    );
  }
}
