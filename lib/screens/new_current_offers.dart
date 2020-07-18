import 'package:flutter/material.dart';
import '../models/pending_offer.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Current Offers")),
      body: SingleChildScrollView(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    final screenWidth = MediaQuery.of(context).size.width;
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          pendingOffers[index].isExpanded = !isExpanded;
        });
      },
      children: pendingOffers.map<ExpansionPanel>((PendingOffer offer) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: offer.picture,
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(offer.driverName),
                    Text(offer.rating.toString()),
                    Text(offer.vehicleName, style: TextStyle(fontSize: 10)),
                  ]),
              trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(offer.minutesAway.toString() + " min away",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        )),
                    Text("\$" + offer.cost.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 25,
                        )),
                  ]),
            );
          },
          body: ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: screenWidth / 4,
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text("Accept"),
                      onPressed: () {}),
                ),
                ButtonTheme(
                  minWidth: screenWidth / 4,
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      child: Text("Reject"),
                      onPressed: () {}),
                ),
                ButtonTheme(
                  minWidth: screenWidth / 4,
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text("Counter"),
                      onPressed: () {}),
                ),
              ]),
          isExpanded: offer.isExpanded,
        );
      }).toList(),
    );
  }
}
