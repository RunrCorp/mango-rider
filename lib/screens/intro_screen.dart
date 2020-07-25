import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> getPages() {
  return [
    PageViewModel(
      title: "hello to you",
      body: "this says hello to you",
      footer: Text("but hello to you"),
    ),
    PageViewModel(
      title: "Hello #2",
      body: "this says hell to you a second time",
      footer: Text("again, hello to you"),
    )
  ];
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
            pages: getPages(), done: Text("Hello"), onDone: () {}));
  }
}
