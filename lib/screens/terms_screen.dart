import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Service"),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/terms.txt'),
            builder: (context, snapshot) =>
                Text(snapshot.data ?? '', softWrap: true),
          ),
        ),
      ),
    );
  }
}
