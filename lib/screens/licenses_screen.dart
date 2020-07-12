import 'package:flutter/material.dart';

class LicensesScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open source licenses"),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/licenses.txt'),
            builder: (context, snapshot) =>
                Text(snapshot.data ?? '', softWrap: true),
          ),
        ),
      ),
    );
  }
}
