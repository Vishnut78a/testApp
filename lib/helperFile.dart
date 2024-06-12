

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled3/model/TestModel.dart';

var s =Stopwatch();
String f = "";
String fileName = "";
List<String> questionStatus = ["Attempted","Marked","UnAttempted"];
List<Color> questionStatusColor = [Colors.greenAccent.shade400, Colors.yellow.shade100, Colors.redAccent.shade200];
List<TestModel> l =[];
Set<TestModel> attempted = <TestModel>{} ;
Set<TestModel> correctAnswers = <TestModel>{};
late Box box;
Set<String> savedTestFiles = {};




optionTapped(TestModel testModel,int index){
  print("dd");
  if(testModel.questions.isAttempted){                   //Already Attempted Question
    if(testModel.options[index].isMarked){               //Attempted and tapping the same option
      testModel.options[index].isMarked=false;
      testModel.questions.isAttempted=false;
      attempted.remove(testModel);
      correctAnswers.remove(testModel);
    }else{                                               //Attempted and tapping another option
    for(int i = 0;i<testModel.options.length;i++) {
      testModel.options[i].isMarked = false;
    }
    correctAnswers.remove(testModel);
    testModel.options[index].isMarked=true;
    testModel.questions.isAttempted=true;
    attempted.add(testModel);
    testModel.options[index].isCorrect?correctAnswers.add(testModel):null;
    }
  }else                                              //Not Attempted
  {
    testModel.options[index].isMarked=true;
    testModel.questions.isAttempted=true;
    attempted.add(testModel);
    testModel.options[index].isCorrect?correctAnswers.add(testModel):null;
  }

}