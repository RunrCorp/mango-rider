import 'package:flutter/material.dart';
import 'package:mango_rider/models/pending_offer_db.dart';
import 'package:mango_rider/services/firestore_service.dart';
import '../models/pending_offer.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  FirestoreService firestoreService = FirestoreService();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Current Offers")),
      body: _buildPanel(context),
    );
  }

  Widget _buildPanel(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: FirestoreService().getDriverOffers(),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) { 
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data.length > 0) {
                  
                  List<PendingOfferDb> pendingOffers = snapshot.data;
                  
                  return ListView.builder(
                    itemCount: pendingOffers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ExpansionTile(
                          leading: Image.asset("assets/bagginso.png"),
                          title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(pendingOffers[index].driverName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black)),
                                Text(
                                  "4",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text("Grey Honda Civic 2007",
                                    style: TextStyle(fontSize: 10, color: Colors.black)),
                              ]),
                          trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                    "5" + " min away",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    )),
                                Text("\$" + pendingOffers[index].price.toStringAsFixed(2),
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 28,
                                    )),
                              ]),
                          children: <Widget>[
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonTheme(
                                  minWidth: screenWidth / 4,
                                  child: RaisedButton(
                                      textColor: Colors.white,
                                      color: Colors.green,
                                      child: Text("Accept"),
                                      onPressed: () {
                                        firestoreService.acceptDriverOffer(pendingOffers[index], context);
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                  "Ride has been accepted and is on the way")));
                                        Future.delayed(const Duration(milliseconds: 1000),
                                            () {
                                          Navigator.of(context).pop();
                                        });
                                      }),
                                ),
                                ButtonTheme(
                                  minWidth: screenWidth / 4,
                                  child: RaisedButton(
                                      textColor: Colors.white,
                                      color: Colors.red,
                                      child: Text("Reject"),
                                      onPressed: () {
                                        setState(() {
                                          pendingOffers.removeWhere((thisOffer) =>
                                              pendingOffers[index] == thisOffer);
                                        });
                                      }),
                                ),
                                ButtonTheme(
                                  minWidth: screenWidth / 4,
                                  child: RaisedButton(
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      child: Text("Counter"),
                                      onPressed: () {
                                        counterOfferDialog(context).then((onValue) {
                                          print(onValue);
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
            } else {
              //no data
              return Center(
                child: Text("No pending offers to display."),
              );
            }
          } else {
            //still loading
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // Widget __buildPanel(BuildContext context) {
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   return ExpansionPanelList(
  //     expansionCallback: (int index, bool isExpanded) {
  //       setState(() {
  //         pendingOffers[index].isExpanded = !isExpanded;
  //       });
  //     },
  //     children: pendingOffers.map<ExpansionPanel>((PendingOffer offer) {
  //       return ExpansionPanel(
  //         headerBuilder: (BuildContext context, bool isExpanded) {
  //           return ListTile(
  //             leading: offer.picture,
  //             title: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(offer.driverName,
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, fontSize: 18)),
  //                   Text(offer.rating.toString()),
  //                   Text(offer.vehicleName, style: TextStyle(fontSize: 10)),
  //                 ]),
  //             trailing: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: <Widget>[
  //                   Text(offer.minutesAway.toString() + " min away",
  //                       style: TextStyle(
  //                         color: Colors.red,
  //                         fontSize: 12,
  //                       )),
  //                   Text("\$" + offer.cost.toStringAsFixed(2),
  //                       style: TextStyle(
  //                         color: Colors.green,
  //                         fontSize: 32,
  //                       )),
  //                 ]),
  //           );
  //         },
  //         body: ButtonBar(
  //             alignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //               ButtonTheme(
  //                 minWidth: screenWidth / 4,
  //                 child: RaisedButton(
  //                     textColor: Colors.white,
  //                     color: Colors.green,
  //                     child: Text("Accept"),
  //                     onPressed: () {}),
  //               ),
  //               ButtonTheme(
  //                 minWidth: screenWidth / 4,
  //                 child: RaisedButton(
  //                     textColor: Colors.white,
  //                     color: Colors.red,
  //                     child: Text("Reject"),
  //                     onPressed: () {
  //                       setState(() {
  //                         pendingOffers
  //                             .removeWhere((thisOffer) => offer == thisOffer);
  //                       });
  //                     }),
  //               ),
  //               ButtonTheme(
  //                 minWidth: screenWidth / 4,
  //                 child: RaisedButton(
  //                     textColor: Colors.white,
  //                     color: Colors.blue,
  //                     child: Text("Counter"),
  //                     onPressed: () {
  //                       counterOfferDialog(context).then((onValue) {
  //                         print(onValue);
  //                       });
  //                     }),
  //               ),
  //             ]),
  //         isExpanded: offer.isExpanded,
  //       );
  //     }).toList(),
  //   );
  // }

  Future<double> counterOfferDialog(BuildContext context) {
    final controller = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Make a counter offer"),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Enter an amount"),
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              ButtonTheme(
                minWidth: screenWidth / 4,
                child: RaisedButton(
                    textColor: Colors.grey,
                    color: Colors.white,
                    child: Text("Return"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              ButtonTheme(
                minWidth: screenWidth / 4,
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.red,
                    child: Text("Confirm"),
                    onPressed: () {
                      Navigator.of(context).pop(double.parse(controller.text));
                    }),
              ),
            ],
          );
        });
  }
}
