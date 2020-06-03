import 'package:flutter/material.dart';

class Location{
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;

  Location({
    @required this.streetAddress,
    @required this.city,
    @required this.state,
    @required this.zipCode
  });


}