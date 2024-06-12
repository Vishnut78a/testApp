

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import 'controller/Controller.dart';
import 'helperFile.dart';

class SolutionMobileView extends StatefulWidget{
  @override
  State<SolutionMobileView> createState() => _SolutionMobileViewState();
}

class _SolutionMobileViewState extends State<SolutionMobileView> {
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size =MediaQuery.of(context).size;
    return
      Scaffold(
        endDrawer:
        Drawer(
          child:
          Container(
              width: size.width<1045?size.width*.4:size.width*.24,

              child:
              SingleChildScrollView(
                child: Column(
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
                                onTap: (){
                                  l[controller.currentIndex.value].s.stop();
                                  controller.currentIndex.value=index;
                                  Navigator.of(context).pop();
                              },
                                child: Container(
                                    decoration:
                                    BoxDecoration(border: Border.all(),color: l[index].questions.isAttempted?Colors.greenAccent.shade400:Colors.redAccent.shade200),
                                    child:
                                    Center(child: Text("${index+1}"))),
                              ),)),),
                    )
                  ],
                ),
              )
          ),
        ),
        appBar:
        AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leadingWidth: 200,
          leading: Row(children:[
            const Text("Time Remaining  ",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 13),),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.purple.shade50,),
              child:   Text("${39-controller.minute.value}")),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(":"),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color:  Colors.purple.shade50),
              child:   Text("${59-controller.seconds.value%60}")),
          ],),


        ),
        body:
        SingleChildScrollView(
          child: Column(
              children: [
                Container(height: 60,color: Colors.blue.shade50,
                  alignment: Alignment.center,
                  child: Obx(()=> Text(l[controller.currentIndex.value].questions.isAttempted?"Attempted":"Unattempted",style: const TextStyle(fontSize: 18),)),),
                Container(color: Colors.blue.shade100,alignment: Alignment.centerLeft,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Obx(()=> Text("Question-${controller.currentIndex.value+1}",style: const TextStyle(fontSize: 18),)),
                        Row(children: [

                          const SizedBox(width: 10,),
                          const Text("Time Taken:",style: TextStyle(fontSize: 18),),
                          const SizedBox(width: 5,),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.purple.shade50,),padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                            child:   Obx(()=> Text("${l[controller.currentIndex.value].s.elapsed.inMinutes}")),),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(":"),
                          ),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color:  Colors.purple.shade50),padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                            child: Obx(()=> Text("${l[controller.currentIndex.value].s.elapsed.inSeconds}")),),
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
                          Obx(
                            ()=> Container(
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

                                      TeXViewContainer(
                                        style:
                                        TeXViewStyle(
                                            border: const TeXViewBorder.all(TeXViewBorderDecoration(borderWidth: 1,borderColor: Colors.black,borderStyle: TeXViewBorderStyle.solid)),
                                            backgroundColor:
                                            l[controller.currentIndex.value].options[0].isCorrect?(Colors.greenAccent.shade200):l[controller.currentIndex.value].options[0].isMarked?Colors.redAccent:null,
                                            padding: const TeXViewPadding.only(top: 10,bottom: 10,left: 30)),
                                        child:
                                        TeXViewDocument(l[controller.currentIndex.value].options[0].name),),
                                      const TeXViewContainer(child: TeXViewDocument(""),style: TeXViewStyle(height: 20)),

                                      TeXViewContainer(
                                        style:
                                        TeXViewStyle(
                                            border: const TeXViewBorder.all(TeXViewBorderDecoration(borderWidth: 1,borderColor: Colors.black,borderStyle: TeXViewBorderStyle.solid)),
                                            backgroundColor:
                                            l[controller.currentIndex.value].options[1].isCorrect?(Colors.greenAccent.shade200):l[controller.currentIndex.value].options[1].isMarked?Colors.redAccent:null,
                                            padding: const TeXViewPadding.only(top: 10,bottom: 10,left: 30)),
                                        child: TeXViewDocument(l[controller.currentIndex.value].options[1].name),),
                                      const TeXViewContainer(child: TeXViewDocument(""),style: TeXViewStyle(height: 20)),
                                      TeXViewContainer(
                                        style:
                                        TeXViewStyle(
                                            border: const TeXViewBorder.all(TeXViewBorderDecoration(borderWidth: 1,borderColor: Colors.black,borderStyle: TeXViewBorderStyle.solid)),
                                            backgroundColor:
                                            l[controller.currentIndex.value].options[2].isCorrect?(Colors.greenAccent.shade200):l[controller.currentIndex.value].options[2].isMarked?Colors.redAccent:null,
                                            padding: const TeXViewPadding.only(top: 10,bottom: 10,left: 30)),
                                        child:
                                        TeXViewDocument(l[controller.currentIndex.value].options[2].name),),
                                      const TeXViewContainer(child: TeXViewDocument(""),style: TeXViewStyle(height: 20)),

                                      TeXViewContainer(
                                        style:
                                        TeXViewStyle(
                                            border: const TeXViewBorder.all(TeXViewBorderDecoration(borderWidth: 1,borderColor: Colors.black,borderStyle: TeXViewBorderStyle.solid)),
                                            backgroundColor:
                                            l[controller.currentIndex.value].options[3].isCorrect?(Colors.greenAccent.shade200):l[controller.currentIndex.value].options[3].isMarked?Colors.redAccent:null,
                                            padding: const TeXViewPadding.only(top: 10,bottom: 10,left: 30)),
                                        child: TeXViewDocument(l[controller.currentIndex.value].options[3].name),),]),),),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(color:Colors.grey),),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){controller.currentIndex.value!=0?controller.currentIndex.value--:null;print(controller.currentIndex.value);},
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
                         controller.currentIndex.value<=l.length-2?controller.currentIndex.value++:null;print(controller.currentIndex.value);},
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
                        onTap: (){controller.currentIndex.value<=l.length-2?controller.currentIndex.value++:null;print(controller.currentIndex.value);},
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



              ],),
        ),

      );
  }
}