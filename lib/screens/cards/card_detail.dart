import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/enums/card/card_supertype.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';

class CardDetail extends StatelessWidget {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CardContent cardContent = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(cardContent.nameJp),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: null),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _cardDetailImage(cardContent),
              ),
              _cardDetailHeader(cardContent),
              _cardDetailBody(cardContent),
              _cardDetailReference(cardContent),
            ]
        )),
      );
  }

  Image _cardDetailImage(CardContent cardContent) {
    final String gen = cardContent.generation;
    final String setCode = cardContent.setCode.toLowerCase();
    final String cardId = cardContent.cardId.toString();
    final String targetPath = 'assets/img/cards/jp/$gen/$setCode/$cardId.png';

    try {
      return Image.asset(targetPath);
    } catch(e) {
      return Image.network(cardContent.imageUrlOfficial, fit: BoxFit.contain);
    }
  }

  Card _cardDetailHeader(CardContent cardContent) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: EdgeInsets.all(7),
            child: Stack(children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: Stack(children: <Widget>[
                    Center(
                        child: Column(children: <Widget>[
                          Text(cardContent.nameJp),
                          SizedBox(height: 10,),
                          Text(cardContent.generation),
                          Text(cardContent.set),
                        ])
                    )
                  ])
              )
            ])
        )
    );
  }

  Card _cardDetailBody(CardContent cardContent) {
    // TODO: Supertypeによって表示カードWidgetを分ける
    final CardSupertype supertype = CardSupertype.values.where(
            (_supertype) => _supertype.name == cardContent.supertype).toList()[0];
    Column supertypeColumn;
    switch(supertype) {
      case CardSupertype.POKEMON:
        supertypeColumn = _pokemonDetailColumn(cardContent);
        break;
      case CardSupertype.TRAINER:
        supertypeColumn = _trainerDetailColumn(cardContent);
        break;
      case CardSupertype.ENERGY:
        supertypeColumn = _energyDetailColumn(cardContent);
        break;
      default:
        throw Error();
    }
    return Card(
        elevation: 5,
        child: Padding(
            padding: EdgeInsets.all(7),
            child: Stack(children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: Stack(children: <Widget>[
                    Center(
                        child: supertypeColumn
                    )
                  ])
              )
            ])
        )
    );
  }

  Column _pokemonDetailColumn(CardContent cardContent) {
    return Column(children: <Widget>[
      Text(cardContent.nameJp),
      SizedBox(height: 10,),
      Text(cardContent.generation),
      Text(cardContent.set),

      Text(cardContent.attacks[0].name),
      Text(cardContent.attacks[1].name),
      Text(cardContent.ability.toJson().toString())
    ]);
  }
  Column _trainerDetailColumn(CardContent cardContent) {
    return Column(children: <Widget>[
      Text(cardContent.nameJp),
      SizedBox(height: 10,),
      Text(cardContent.generation),
      Text(cardContent.set),
    ]);
  }
  Column _energyDetailColumn(CardContent cardContent) {
    return Column(children: <Widget>[
      Text(cardContent.nameJp),
      SizedBox(height: 10,),
      Text(cardContent.generation),
      Text(cardContent.set),
    ]);
  }

  // TODO: 化石、墓地利用、エネルギー利用、GX(VMAX）、TagTEAM等関連するカードの表示
  Card _cardDetailReference(CardContent cardContent) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: EdgeInsets.all(7),
            child: Stack(children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: Stack(children: <Widget>[
                    Center(
//                        child: Column(children: <Widget>[
//                          Text("TODO: 関連カード"),
//                        ])
                    )
                  ])
              )
            ])
        )
    );
  }
}
