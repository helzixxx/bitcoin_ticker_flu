import 'dart:io';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentValue = 'USD';

  DropdownButton<String> getDropDownButton() {
    return DropdownButton<String>(
      value: currentValue,
      items: getMenuItemList(),
      onChanged: (String? value) {
        currentValue = value!;
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (int value) {
        print(value);
      },
      children: getCupertinoItemList(),
    );
  }

  List<DropdownMenuItem<String>> getMenuItemList() {
    List<DropdownMenuItem<String>> newList = [];
    for (var i = 0; i < currenciesList.length - 1; i++) {
      newList.add(
        DropdownMenuItem<String>(
          value: currenciesList[i],
          child: Text(currenciesList[i]),
        ),
      );
    }
    return newList;
  }

  List<Text> getCupertinoItemList() {
    List<Text> newList = [];
    for (String currency in currenciesList) {
      newList.add(Text(currency));
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropDownButton(),
          ),
        ],
      ),
    );
  }
}
