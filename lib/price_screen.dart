import 'dart:io';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'coin_api.dart';
import 'exchange_rate_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = 'USD';
  dynamic rateData;

  DropdownButton<String> getDropDownButton() {
    return DropdownButton<String>(
      value: currentCurrency,
      items: getMenuItemList(),
      onChanged: (String? value) async {
        currentCurrency = value!;
        updateUI(await fetchExchangeRate(value));
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (int value) async {
        print(currenciesList[value]);
        currentCurrency = currenciesList[value];
        updateUI(await fetchExchangeRate(currenciesList[value]));
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
  void initState() {
    super.initState();
  }

  void updateUI(dynamic data) {
    print('updateUI data: $data');
    setState(() {
      rateData = data;
    });
  }

  List<Widget> columnWidgets() {
    List<Widget> list = [];
    double value = 0.0;

    print('rate: $rateData');

    for (String crypto in cryptoList) {
      try {
        value = rateData[crypto]['rate'];
      } catch (e) {
        print(e);
        value = 0.0;
      }

      list.add(
        ExchangeRateCard(
          btcValue: value.toStringAsFixed(2),
          currentCurrency: currentCurrency,
          currentCrypto: crypto,
        ),
      );
    }
    list.add(Container(
      height: 150.0,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 30.0),
      color: Colors.lightBlue,
      child: Platform.isIOS ? getCupertinoPicker() : getDropDownButton(),
    ));

    return list;
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
        children: columnWidgets(),
      ),
    );
  }
}
