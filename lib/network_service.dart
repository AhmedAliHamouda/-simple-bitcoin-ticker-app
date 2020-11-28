import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  NetworkService(this.coinURL);
  final String coinURL;

  Future getDataCoin() async {
    http.Response httpResponse = await http.get(coinURL);
    if (httpResponse.statusCode == 200) {
      String weatherData = httpResponse.body;
      return jsonDecode(weatherData);
    } else {
      print(httpResponse.statusCode);
    }
  }
}
