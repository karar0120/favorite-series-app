import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb/Business_logic/cubit/AppCubit.dart';
import 'package:imdb/Business_logic/cubit/App_State.dart';
import 'package:imdb/Presentation/widget/CharacterItem.dart';

import '../../Constants/My_Colors.dart';
import '../../data/models/Characters.dart';

class CharacterSearch extends StatelessWidget {
  @override
  late List<characters> Allcharacters;
  var cubit;

  Widget BuildBLocWidget() {
    return BlocConsumer<CharactersCubit, CharactersState>(
        listener: (context, state) {},
        builder: (context, state) {
          CharactersCubit.get(context).getAllCharacter();
          cubit = CharactersCubit.get(context);
          if (state is CharactersLoaded) {
            Allcharacters = (state).character;
            return BuildLoadedListWidget(context);
          } else {
            return ShowProgressIndicator();
          }
        });
  }

  Widget _buildAppBar() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColor.MyGrey),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.MyYallow,
        title: CharactersCubit.get(context).isSearch
            ? _SearchField(context)
            : _buildAppBar(),
        leading: CharactersCubit.get(context).isSearch
            ? BackButton(
                color: MyColor.MyGrey,
              )
            : Container(),
        actions: CharactersCubit.get(context).AppBarAction(context),
      ),
      body: BuildBLocWidget(),
    );
  }

  Widget BuildLoadedListWidget(context) {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.MyGrey,
        child: Column(
          children: [
            BuildCharactersList(context),
          ],
        ),
      ),
    );
  }

  Widget ShowProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColor.MyYallow,
      ),
    );
  }

  Widget BuildCharactersList(context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 2 / 3,
        ),
        itemCount:
            CharactersCubit.get(context).SearchEditController.text.isEmpty
                ? Allcharacters.length
                : CharactersCubit.get(context).SearchCharacterItme.length,
        //Allcharacters.length,
        //_SearchTextEditController.text.isEmpty?Allcharacters.length:CharactersCubit.get(context).SearchCharacterItme.length,

        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CharacterItem(
            Characters:
                CharactersCubit.get(context).SearchEditController.text.isEmpty
                    ? Allcharacters[index]
                    : CharactersCubit.get(context).SearchCharacterItme[index],
            ////_SearchedForCharacters[index],
          );
        });
  }

  Widget _SearchField(context) {
    return TextField(
      controller: CharactersCubit.get(context).SearchEditController,
      cursorColor: MyColor.MyGrey,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Find a characters ",
        hintStyle: TextStyle(color: MyColor.MyGrey, fontSize: 18),
        border: InputBorder.none,
      ),
      style: TextStyle(color: MyColor.MyGrey, fontSize: 18),
      onChanged: (SearchCharacter) {
        //CharactersCubit.get(context).addSearchorItemtoSearchList(SearchCharacter);
        cubit.addSearchorItemtoSearchList(SearchCharacter);
      },
    );
  }
}
