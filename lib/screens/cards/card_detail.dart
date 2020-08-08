import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptcgb_flutter/enums/cards/card_supertype.dart';
import 'package:ptcgb_flutter/models/cards/attack_content.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';

class CardDetail extends StatelessWidget {
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
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: _cardDetailImage(cardContent),
                builder: (BuildContext context, snapshot) =>
                    snapshot.hasData ? snapshot.data : CircularProgressIndicator(),
              ),
            ),
            _cardDetailHeader(cardContent),
            ..._cardDetailBody(cardContent),
            _cardDetailReference(cardContent),
          ])),
    );
  }

  Future<Image> _cardDetailImage(CardContent cardContent) {
    final String gen = cardContent.generation;
    final String setCode = cardContent.setCode.toLowerCase();
    final String cardId = cardContent.cardId.toString();
    final String targetPath = 'assets/img/cards/jp/$gen/$setCode/$cardId.png';

    var imageAsset = (String targetPath, CardContent cardContent) async =>
        (await (isLocalAsset(targetPath))
            ? Image.asset(targetPath, fit: BoxFit.contain)
            : Image.network(cardContent.imageUrlOfficial, fit: BoxFit.contain));

    return imageAsset(targetPath, cardContent);
  }

  Future<bool> isLocalAsset(String assetPath) async {
    try {
      await rootBundle.loadString(assetPath);
      return true;
    } catch (_) {
      return false;
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(cardContent.generation),
                          Text(cardContent.set),
                        ]))
                  ]))
            ])));
  }

  List<Card> _cardDetailBody(CardContent cardContent) {
    List<Card> cardSupertype;
    switch (cardContent.cardSupertype) {
      case CardSupertypeEnum.POKEMON:
        cardSupertype = _pokemonDetailColumn(cardContent);
        break;
      case CardSupertypeEnum.TRAINER:
        cardSupertype = _trainerDetailColumn(cardContent);
        break;
      case CardSupertypeEnum.ENERGY:
        cardSupertype = _energyDetailColumn(cardContent);
        break;
      default:
        throw Error();
    }

    return cardSupertype;
  }

  List<Card> _pokemonDetailColumn(CardContent cardContent) {
    final bool isAbiliter = cardContent.ability.name != null;
    final int attackNum = cardContent.attacks.length;

    // アビリティの有無で表示を切り替える
    final Card ability = isAbiliter ? _abilityCardWidget(cardContent) : null;
    // attacksの数で表示を切り替える
    List<Card> attacks;
    switch (attackNum) {
      case 0:
        attacks = null;
        break;
      case 1:
        final atk1 = cardContent.attacks[0];
        attacks = [_attackCardWidget(atk1)];
        break;
      case 2:
        final atk1 = cardContent.attacks[0];
        final atk2 = cardContent.attacks[1];
        attacks = [_attackCardWidget(atk1), _attackCardWidget(atk2)];
        break;
    }

    return [ability, ...attacks].where((val) => val != null).toList();
  }

  Card _abilityCardWidget(CardContent cardContent) {
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
                          Text("特性"),
                          Text(cardContent.ability.name),
                          Text(cardContent.ability.text)
                        ]))
                  ]))
            ])));
  }

  Card _attackCardWidget(AttackContent attackContent) {
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(attackContent.costs.toList().toString()),
                                Text(attackContent.name),
                                Text(attackContent.damage)
                              ]),
                          Text(attackContent.text),
                        ]))
                  ]))
            ])));
  }

  List<Card> _trainerDetailColumn(CardContent cardContent) {
    return [_textCardWidget(cardContent.trainerText)];
  }

  List<Card> _energyDetailColumn(CardContent cardContent) {
    return [_textCardWidget(cardContent.energyText)];
  }

  Card _textCardWidget(String text) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: EdgeInsets.all(7),
            child: Stack(children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: Stack(children: <Widget>[
                    Center(child: Column(children: <Widget>[Text(text)]))
                  ]))
            ])));
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
                  ]))
            ])));
  }
}
