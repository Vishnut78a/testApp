
import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<TestModel>> getTestModelList()async{
  var s = await rootBundle.loadString("assets/data/test.json");
  Map<String,dynamic> decodedData = await jsonDecode(s);

  List<TestModel> l = listOfQandA(decodedData['data']['sections'][0]['questions'] );
  print("dddddd......................");
  print(l[0].questions.name);print(l[0].questions.nameText);
  print(l[0].options[0].name);print(l[0].options[0].nameText);print(l[0].options[0].id);
  print(l[0].options[0].isCorrect);print(l[0].options[0].isMarked);print(l.length);
  return l;
}

List<TestModel> listOfQandA(List<dynamic> json){
  List<TestModel> l = json.map((e) => TestModel.fromJson(e)).toList();

  return l;
}

class TestModel{
Questions questions;
List<Options> options;
var s =Stopwatch();

TestModel({ required this.questions,required this.options});

factory TestModel.fromJson(Map<String,dynamic> json){ //question[i] object

  return

  TestModel(
  questions: Questions.fromJson(json['name'],json['nameText']),
  options: Options.f(json['options']));
}

}
class Questions{
  String name;
  String nameText;
  bool isAttempted=false;
  bool markedForReview;
  Questions({required this.name,required this.nameText,this.markedForReview=false,this.isAttempted=false});

  factory Questions.fromJson(String name,String nameText){
    return 
      Questions(
          name: name,
          nameText: nameText);
  }
}
class Options{
  String name;
  String nameText;
  bool isCorrect;
  String id;
  bool isMarked;
  Options({required this.id,required this.name,required this.isCorrect, required this.nameText,this.isMarked=false});

  static List<Options> f(List<dynamic> json){
    var l = json.map((e) => Options.fromJson(e)).toList();
    for( var i in l ){


    };
    return l; }


  factory Options.fromJson(Map<String,dynamic> json){

    return

      Options(
        name: json['name']??"",
        nameText: json['nameText']??"",
        isCorrect: json['isCorrect'],
        id: json['_id'],
      );
  }

}