import 'package:flutter/material.dart';

class RunnerLocation {
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;

  RunnerLocation(
      {@required this.streetAddress,
      @required this.city,
      @required this.state,
      @required this.zipCode});
}
