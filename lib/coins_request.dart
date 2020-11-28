import 'network_service.dart';

const apiKey = '62D51743-455B-4763-A405-B1ADC827145F';
const apiKey2 = '59AEF314-2754-4FE5-A69E-89B0A058F16D';
const BtcCoinDataURL = 'https://rest.coinapi.io/v1/exchangerate';
const List<String> coinNames = ['BTC', 'ETH', 'LTC'];

class CoinsModel {
  Future getCurrentCoinData(String currentCurrencyName) async {
    Map<String, String> coinPrices = {};

    for (String coinName in coinNames) {
      var btcURL =
          '$BtcCoinDataURL/$coinName/$currentCurrencyName?apikey=$apiKey2';
      NetworkService networkService = NetworkService(btcURL);
      var dataBTCCoin = await networkService.getDataCoin();
      var priceCoinData = dataBTCCoin['rate'];
      coinPrices[coinName] = priceCoinData.toStringAsFixed(0);
    }

    return coinPrices;
  }
}
