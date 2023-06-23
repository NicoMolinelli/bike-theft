import 'package:flutter/material.dart';

class Bike {

  // final int id;

  final String imgPath;

  final String name;

  final String frameId;

  final bool isStolen;

  Bike(
    this.imgPath,
    this.name,
    this.frameId,
    this.isStolen
  );

  static Bike mock() {
    return Bike(
      'assets/bike.jpg',
      'Bike',
      'CO872TGS213TR',
      false
    );
  }

}
