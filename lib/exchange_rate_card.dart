import 'package:flutter/material.dart';

class ExchangeRateCard extends StatelessWidget {
  const ExchangeRateCard({
    super.key,
    required this.btcValue,
    required this.currentCurrency,
    required this.currentCrypto,
  });

  final String btcValue;
  final String currentCurrency;
  final String currentCrypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $currentCrypto = $btcValue $currentCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
