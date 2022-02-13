import 'dart:io';

import 'package:flutter/material.dart';

class UserModel {
  int id;
  final String img;
  final String title;

  final String category;

  final String user;
  final String pass;
  UserModel(
      {@required this.id,
      @required this.img,
      @required this.title,
      @required this.category,
      @required this.user,
      @required this.pass});

  factory UserModel.fromMap(Map<dynamic, dynamic> json) => UserModel(
        id: json["id"],
        img: json["img"],
        title: json["title"],
        category: json["category"],
        user: json["user"],
        pass: json["pass"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "img": img,
        "title": title,
        "category": category,
        "user": user,
        "pass": pass
      };
}
