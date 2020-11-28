import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'coins_request.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  CoinsModel coinsModel = CoinsModel();
  //String priceCoin = '?';
  Map<String, String> coinsName = {};

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() async {
    var currentPriceCurrencyData =
        await coinsModel.getCurrentCoinData(selectedCurrency);
    if (currentPriceCurrencyData == null) {
      coinsName = {};
    }

    setState(() {
      coinsName = currentPriceCurrencyData;
    });
  }

  DropdownButton androidDropDown() {
    List<DropdownMenuItem> currencyList = [];

    for (String currency in currenciesList) {
      var newItemList = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      currencyList.add(newItemList);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: currencyList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> itemsPicker = [];
    for (String currency in currenciesList) {
      Text nameCurrency = Text(currency);
      itemsPicker.add(nameCurrency);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      looping: true,
      itemExtent: 50.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency=currenciesList[selectedIndex];
        updateUI();
      },
      children: itemsPicker,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ViewScreen(
                coinCurrency: 'BTC',
                priceCoin: coinsName['BTC'],
                selectedCurrency: selectedCurrency,
              ),
              ViewScreen(
                coinCurrency: 'ETH',
                priceCoin: coinsName['ETH'],
                selectedCurrency: selectedCurrency,
              ),
              ViewScreen(
                coinCurrency: 'LTC',
                priceCoin: coinsName['LTC'],
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

class ViewScreen extends StatelessWidget {
  const ViewScreen({
    @required this.priceCoin,
    @required this.selectedCurrency,
    @required this.coinCurrency,
  });

  final String priceCoin;
  final String selectedCurrency;
  final String coinCurrency;

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
            '1 $coinCurrency = $priceCoin $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
