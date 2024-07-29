// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Shape {
  Square,
  Star,
  Circle,
  Triangle,
  Cross,
  Whot,
  Other,
}

class WhotCardModel {
  final int value;
  final String shape;
  final String move;
  final int score;
  final String image;

  WhotCardModel({
    required this.value,
    required this.shape,
    required this.move,
    required this.score,
    required this.image,
  });

  factory WhotCardModel.fromJson(Map<String, dynamic> json) {
    return WhotCardModel(
      image: shapeToImage(stringToShape(json['shape'])),
      value: json['value'],
      shape: json['shape'],
      move: json['move'],
      score: json['score'],
    );
  }

  static Shape stringToShape(String shape) {
    switch (shape.toUpperCase().trim()) {
      case "SQUARE":
        return Shape.Square;
      case "STAR":
        return Shape.Star;
      case "CIRCLE":
        return Shape.Circle;
      case "TRIANGLE":
        return Shape.Triangle;
      case "CROSS":
        return Shape.Triangle;
      case "WHOT":
        return Shape.Triangle;
      default:
        return Shape.Other;
    }
  }

  static String shapeToString(Shape shape) {
    switch (shape) {
      case Shape.Square:
        return "Square";
      case Shape.Star:
        return "Star";
      case Shape.Circle:
        return "Circle";
      case Shape.Triangle:
        return "Triangle";
      case Shape.Cross:
        return "Cross";
      case Shape.Whot:
        return "Whot";
      case Shape.Other:
        return "Other";
    }
  }

  static String shapeToImage(Shape shape) {
    switch (shape) {
      case Shape.Square:
        return "assets/images/card-square.svg";
      case Shape.Star:
        return "assets/images/card-star.svg";
      case Shape.Circle:
        return "assets/images/card-circle.svg";
      case Shape.Triangle:
        return "assets/images/card-triangle.svg";
      case Shape.Cross:
        return "assets/images/card-cross.svg";
      case Shape.Whot:
        return "assets/images/small/card-whot.svg";
      case Shape.Other:
        return "assets/images/card-other.svg";
    }
  }

  // static Color suitToColor(Suit suit) {
  //   switch (suit) {
  //     case Suit.Hearts:
  //     case Suit.Diamonds:
  //       return Colors.red;
  //     default:
  //       return Colors.black;
  //   }
  // }
}
