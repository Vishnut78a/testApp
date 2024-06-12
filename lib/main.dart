import 'dart:async';
import 'dart:convert';
import 'dart:io';




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:html/dom.dart' as htmlDom;
import 'package:html/parser.dart' as htmlParser;
import 'package:untitled3/FileSelectionPage.dart';
import 'package:untitled3/Summary.dart';
import 'package:untitled3/controller/Controller.dart';
import 'package:untitled3/helperFile.dart';
import 'package:untitled3/model/mobileView.dart';

import 'model/TestModel.dart';

void main() async{
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  runApp(MaterialApp(home: FileSelectionPage(),));
}

class MyApp extends StatefulWidget {
  Controller controller = Get.put(Controller());
  MyHomePage myHomePage;
  MobileView mobileView;
   MyApp({super.key,required this.mobileView,required this.myHomePage});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState

    super.initState();


  }
  /*getTestModelList()async{
   // String fileContent =  File(widget.controller.jsontTestFile.value.path).readAsStringSync();
    //var s = await rootBundle.loadString(fileContent);
    //var s = await rootBundle.loadString("assets/data/test.json");
    print("d");
    print("${widget.controller.jsonDecodedFile.value}");
    print( "dsf:${widget.controller.jsonDecodedFile.value.isEmpty}");
    Map<String,dynamic> decodedData = await jsonDecode(f);

    print("d");
    print(decodedData);
    l = listOfQandA(decodedData['data']['sections'][0]['questions'] );
    widget.controller.li.value=true;
    setState(() {

    });
  }

   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      LayoutBuilder(
          builder: (context,constraints){
          if(constraints.maxWidth<=768){
            return widget.mobileView;
          }
          else{
            return widget.myHomePage;
    }}));//MyHomePage(title: ""),

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Controller controller = Get.put(Controller());
  int _counter = 0;

  
   bool detailedView = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     print("object");
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {
      s.start(),
      setState(() {})});

    Timer.periodic(const Duration(seconds: 1), (timer) {
      controller.minute.value=s.elapsed.inMinutes;
      controller.seconds.value=s.elapsed.inSeconds;

      if(controller.minute.value==2 && controller.seconds.value%60 ==0){
        timer.cancel();
        s.stop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SummaryPage()));
      }
    });


  }






  @override

  Widget build(BuildContext context) {
    if(controller.submitted.value)
    {}
    else {
      l.isNotEmpty ? l[controller.currentIndex.value].s.start() : null;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        controller.currentQuestionMinute.value =
            l[controller.currentIndex.value].s.elapsed.inMinutes;
        controller.currentQuestionSecond.value =
            l[controller.currentIndex.value].s.elapsed.inSeconds % 60;
      });
    }
      final size = MediaQuery.of(context).size;
      return Scaffold(

        appBar:
        AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            const Text("Time Remaining  ",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.purple.shade50,),padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
              child:  Obx(()=> Text("${39-controller.minute.value}")),),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(":"),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color:  Colors.purple.shade50),padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
              child:  Obx(()=> Text("${59-controller.seconds.value%60}")),),
            const SizedBox(width: 50,)],
        ),
        body:
         SingleChildScrollView(
            child:
           // controller.li.value?
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(height: 60,color: Colors.blue.shade50,),
                      Container(color: Colors.blue.shade100,alignment: Alignment.centerLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Question-${controller.currentIndex.value+1}",style: const TextStyle(fontSize: 18),),
                              Row(children: [

                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.purple.shade50,),padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                  child:  Obx(()=> Text("${controller.currentQuestionMinute.value}")),),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(":"),
                                ),
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color:  Colors.purple.shade50),padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                  child:  Obx(()=> Text("${controller.currentQuestionSecond.value}")),),
                              ],)

                            ],
                          ),
                        ),),
                      Container(width: size.width,
                        child:
                        Row(
                          mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40.0,bottom: 40,left: 40),
                                child:
                                Container(
                                  decoration: BoxDecoration(border: Border.all(color:Colors.grey),borderRadius: BorderRadius.circular(5)),
                                  height: 300,
                                  padding: const EdgeInsets.all(10),
                                  child:
                                  TeXView(
                                    child:
                                    TeXViewColumn(
                                        children: [
                                          TeXViewContainer(
                                            style: const TeXViewStyle(padding: TeXViewPadding.only(top: 20,bottom: 50,left: 10)),
                                            child: TeXViewDocument(l[controller.currentIndex.value].questions.name),),
                                          TeXViewInkWell(
                                            onTap: (id){print("print");optionTapped(l[controller.currentIndex.value], 0);setState(() {});},
                                            id: "id0",
                                            child:
                                            TeXViewContainer(
                                              style:
                                              TeXViewStyle(
                                                  border: const TeXViewBorder.all(TeXViewBorderDecoration(borderWidth: 1,borderColor: Colors.black,borderStyle: TeXViewBorderStyle.solid)),
                                                  backgroundColor:l[controller.currentIndex.value].options[0].isMarked?Colors.greenAccent.shade200:null,
                                                  padding: const TeXViewPadding.only(top: 10,bottom: 10,left: 30)),
                                              child:
                                              TeXViewDocument(l[controller.currentIndex.value].options[0].name),),),
                                          const TeXViewContainer(child: TeXViewDocument(""),style: TeXViewStyle(height: 20)),
                                          TeXViewInkWell(
                                            onTap: (id){print("print");optionTapped(l[controller.currentIndex.value], 1);setState(() {});},
                                            id: "id1",
                                            child:
                                            TeXViewContainer(
                                              style:
                                              TeXViewStyle(
                                                  border: const TeXViewBorder.all(TeXViewBorderDecoration(borderWidth: 1,borderColor: Colors.black,borderStyle: TeXViewBorderStyle.solid)),
                                                  backgroundColor:l[controller.currentIndex.value].options[1].isMarked?Colors.greenAccent.shade200:null,
                                                  padding: const TeXViewPadding.only(top: 10,bottom: 10,left: 30)),
                                              child: TeXViewDocument(l[controller.currentIndex.value].options[1].name),),),
                                          const TeXViewContainer(child: TeXViewDocument(""),style: TeXViewStyle(height: 20)),
                                          TeXViewInkWell(
                                            onTap: (id){print("print");optionTapped(l[controller.currentIndex.value], 2);setState(() {});},
                                            id: "id2",
                                            child:
                                            TeXViewContainer(
                                              style:
                                              TeXViewStyle(
                                                  border: const TeXViewBorder.all(TeXViewBorderDecoration(borderWidth: 1,borderColor: Colors.black,borderStyle: TeXViewBorderStyle.solid)),
                                                  backgroundColor:l[controller.currentIndex.value].options[2].isMarked?Colors.greenAccent.shade200:null,
                                                  padding: const TeXViewPadding.only(top: 10,bottom: 10,left: 30)),
                                              child:
                                              TeXViewDocument(l[controller.currentIndex.value].options[2].name),),),
                                          const TeXViewContainer(child: TeXViewDocument(""),style: TeXViewStyle(height: 20)),
                                          TeXViewInkWell(
                                            onTap: (id){print("print");optionTapped(l[controller.currentIndex.value], 3);setState(() {});},
                                            id: "id3",
                                            child:
                                            TeXViewContainer(
                                              style:
                                              TeXViewStyle(
                                                  border: const TeXViewBorder.all(TeXViewBorderDecoration(borderWidth: 1,borderColor: Colors.black,borderStyle: TeXViewBorderStyle.solid)),
                                                  backgroundColor:l[controller.currentIndex.value].options[3].isMarked?Colors.greenAccent.shade200:null,
                                                  padding: const TeXViewPadding.only(top: 10,bottom: 10,left: 30)),
                                              child: TeXViewDocument(l[controller.currentIndex.value].options[3].name),),),]),),),
                              ),
                            ),
                            TextButton(
                                onPressed: (){detailedView?{setState(() {detailedView=false;})}:{setState(() {detailedView=true;})};},
                                child:  Icon(detailedView?CupertinoIcons.right_chevron:CupertinoIcons.left_chevron)),

                          ],
                        ),
                      ),
                      Container(padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(color:Colors.grey),),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){

                                setState(() {controller.currentIndex.value!=0?{l[controller.currentIndex.value].s.stop(),controller.currentIndex.value--, }:null;print(controller.currentIndex.value);});},
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 40),decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(5)),
                                child:
                                const
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.left_chevron,size: 21,),
                                    Text(" Previous",style: TextStyle(fontSize: 15),),
                                  ],
                                ),),
                            ),
                            controller.currentIndex.value==l.length-1
                                ?
                            GestureDetector(
                              onTap: (){
                                if(controller.currentIndex.value==l.length-1){
                                  l[controller.currentIndex.value].s.stop();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SummaryPage()));
                                  controller.submitted.value=true;
                                  s.stop();
                                }
                                else{
                                  setState(() {

                                    controller.currentIndex.value<=l.length-2?{l[controller.currentIndex.value].s.stop(),controller.currentIndex.value++}:null;print(controller.currentIndex.value);});}},
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 40),decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(5)),
                                child:
                                const
                                Row(
                                  children: [
                                    Text("Submit",style: TextStyle(fontSize: 15),),
                                    Icon(CupertinoIcons.right_chevron,size: 21,),
                                  ],
                                ),),
                            )
                                :
                            GestureDetector(
                              onTap: (){

                                setState(() {
                                  controller.currentIndex.value<=l.length-2?{l[controller.currentIndex.value].s.stop(),controller.currentIndex.value++,}:null;print(controller.currentIndex.value);
                                });

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 40),decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(5)),
                                child:
                                const
                                Row(
                                  children: [
                                    Text("Next",style: TextStyle(fontSize: 15),),
                                    Icon(CupertinoIcons.right_chevron,size: 21,),
                                  ],
                                ),),
                            )

                            ,
                          ],),
                      ),


                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],),
                ),

                detailedView
                    ?
                Container(
                    width: size.width<1045?size.width*.4:size.width*.24,

                    child:
                    Column(
                      children: [
                        Card(

                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),color: Colors.white,
                          child:
                          Container(padding: const EdgeInsets.symmetric(horizontal: 3),
                            height: 150,

                            child:
                            GridView.builder(
                                itemCount: questionStatus.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2.8),
                                itemBuilder: (context,index)=>
                                    Container(
                                      child:
                                      Row(
                                        children: [
                                          Container(
                                              height: 30,
                                              width: 30,
                                              decoration:
                                              BoxDecoration(
                                                  color: questionStatusColor[index],
                                                  borderRadius: questionStatus[index]=="Marked"?BorderRadius.circular(40):BorderRadius.circular(1)),
                                              child:
                                              Center(
                                                  child:
                                                  Text(
                                                      index==0
                                                          ?"${attempted.length}"
                                                          :index==2
                                                          ?"${l.length-attempted.length}"
                                                          :"${0}"))),

                                          Text(questionStatus[index]),
                                        ],
                                      ),
                                    )),),
                        ),
                        Card(color: Colors.white,
                          child:
                          Container(
                            height:500 ,
                            child:
                            GridView.builder(
                                itemCount:l.length ,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,),
                                itemBuilder: (context,index)
                                =>Container(padding: const EdgeInsets.all(5),

                                  child:
                                  GestureDetector(
                                    onTap: (){setState(() {
                                      l[controller.currentIndex.value].s.stop();
                                      controller.currentIndex.value=index;
                                    });},
                                    child: Container(
                                        decoration:
                                        BoxDecoration(border: Border.all(),color: l[index].questions.isAttempted?Colors.greenAccent.shade400:Colors.redAccent.shade200),
                                        child:
                                        Center(child: Text("${index+1}"))),
                                  ),)),),
                        )
                      ],
                    )
                )
                    :const SizedBox()
              ],
            )//:const SizedBox(child: Text("No Data"),),
          ),


        // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }

