// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromMap(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromMap(x)));

String welcomeToMap(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Welcome {
    Welcome({
      required  this.available,
  
     
      required  this.column,



      required  this.name,

      required  this.row,

    });

    String available;
 
    String column;

    String name;

    String row;


    factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
        available: json["available"],

        column: json["column"],

        name: json["name"],

        row: json["row"],

    );

    Map<String, dynamic> toMap() => {
        "available": available,

        "column": column,

        "name": name,

        "row": row,

    };
}
