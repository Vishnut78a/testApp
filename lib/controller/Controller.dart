

import 'dart:io';

import 'package:get/get.dart';
import 'package:untitled3/helperFile.dart';



class Controller extends GetxController{

  RxInt minute =0.obs;
  RxInt seconds = 0.obs;

  RxInt currentQuestionMinute = 0.obs;
  RxInt currentQuestionSecond = 0.obs;

  RxBool submitted = false.obs;
  RxBool li = false.obs;

  RxInt currentIndex = 0.obs;
  
  RxString jsonDecodedFile = "".obs;
  Rx<File> jsontTestFile = File("path").obs;

  questionTimer(int tappedIndex){
    l[currentIndex.value].s.stop();
    currentIndex.value=tappedIndex;
    l[tappedIndex].s.start();

  }

  next(){
    l[currentIndex.value].s.stop();
    currentIndex++;
    l[currentIndex.value].s.start();
  }

  previous(){
    l[currentIndex.value].s.stop();
    currentIndex--;
    l[currentIndex.value].s.start();
  }
}