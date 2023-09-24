import 'dart:convert';

import 'package:http/http.dart' as http;
import 'coin_data.dart';

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '40671FB0-D34B-4BA5-A363-C893BC36CDBA';

Future<dynamic> fetchExchangeRate(String currency) async {
  String url;
  var cryptoMap = {};
  for (String crypto in cryptoList) {
    url = '$coinApiUrl/$crypto/$currency?apiKey=$apiKey';
    var rateData = await getData(url);
    cryptoMap[crypto] = rateData;
  }
  //var rateData = await getData(url);
  return cryptoMap;
}

Future getData(String url) async {
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    String data = response.body;
    var decodedData = jsonDecode(data);
    return decodedData;
  } else {
    print(response.statusCode);
  }
}
