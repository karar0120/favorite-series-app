// ignore_for_file: unused_label

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:imdb/Business_logic/cubit/AppCubit.dart';
import 'package:imdb/Business_logic/cubit/App_State.dart';
import 'package:imdb/Constants/My_Colors.dart';
import 'package:imdb/data/models/Characters.dart';
import '../widget/CharacterItem.dart';

class Characters_Screen extends StatefulWidget {
  @override
  State<Characters_Screen> createState() => _Characters_ScreenState();
}

class _Characters_ScreenState extends State<Characters_Screen> {
  late List<characters> Allcharacters;
  late List<characters> _SearchedForCharacters;
  bool _isSearched = false;
  var _SearchTextEditController = TextEditingController();

  Widget _SearchField() {
    return TextField(
      controller: _SearchTextEditController,
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
        addSearchorItemtoSearchList(SearchCharacter);
      },
    );
  }

  void addSearchorItemtoSearchList(SearchCharacter) {
    _SearchedForCharacters = Allcharacters.where((character) =>
        character.name.toLowerCase().startsWith(SearchCharacter)).toList();
    setState(() {});
  }

  List<Widget> _BuildAppBarAction() {
    if (_isSearched) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColor.MyGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColor.MyGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _StopSearch));
    setState(() {
      _isSearched = true;
    });
  }

  void _StopSearch() {
    clearSearch();
    setState(() {
      _isSearched = false;
    });
  }

  void clearSearch() {
    setState(() {
      _SearchTextEditController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacter();
    //BlocProvider.of<CharactersCubit>(context).addSearchorItemtoSearchList(searchCharacter);
    // TODO: implement initState
  }

  Widget BuildBLocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        Allcharacters = (state).character;
        return BuildLoadedListWidget();
      } else {
        return ShowProgressIndicator();
      }
    });
  }

  Widget ShowProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColor.MyYallow,
      ),
    );
  }

  Widget BuildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.MyGrey,
        child: Column(
          children: [
            BuildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget BuildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 2 / 3,
        ),
        itemCount: _SearchTextEditController.text.isEmpty
            ? Allcharacters.length
            : _SearchedForCharacters.length,
        //_SearchTextEditController.text.isEmpty?Allcharacters.length:CharactersCubit.get(context).SearchCharacterItme.length,

        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CharacterItem(
            Characters: _SearchTextEditController.text.isEmpty
                ? Allcharacters[index]
                : _SearchedForCharacters[
                    index], //_SearchedForCharacters[index],
          );
        });
  }

  Widget _buildAppBar() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColor.MyGrey),
    );
  }

  Widget BuildNoInternetInWidget(){
    return Center(
      child: Container(
        color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text("can't Connect ... check internet",style: TextStyle(
            fontSize: 22,
            color: MyColor.MyGrey,
          ),),
          Image.asset('assets/images/no_inter_connet.png',fit: BoxFit.cover,)
        ],
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColor.MyYallow,
          title: _isSearched ? _SearchField() : _buildAppBar(),
          leading: _isSearched
              ? BackButton(
                  color: MyColor.MyGrey,
                )
              : Container(),
          actions: _BuildAppBarAction()),
      body:OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected){
          return BuildBLocWidget();
        }
        else {
          return BuildNoInternetInWidget();
        }
      },
          child:ShowProgressIndicator(),
      )
      //
    );
  }
}
