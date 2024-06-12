
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/SolutionMobileView.dart';
import 'package:untitled3/SolutionPage.dart';
import 'package:untitled3/controller/SolutionPageResp.dart';
import 'package:untitled3/sample.dart';

import 'controller/Controller.dart';
import 'helperFile.dart';

class SummaryPage extends StatelessWidget{
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    return
      WillPopScope(
        onWillPop: ()async{l=[];return true;},
        child: Scaffold(
          appBar:
          AppBar(title: const Text("Summary",style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor: Colors.blue,),
          body:
              size.width>=768
                  ?
           Center(
             child: Padding(
               padding: const EdgeInsets.all(30.0),
               child: Card(
                 child: Container(
                   color: Colors.white,
                   width: size.width*.5,
                   padding: const EdgeInsets.symmetric(vertical: 30,),
                   child:
                    SingleChildScrollView(
                      child:
                      Column(
                        children: [
                          const Text("Score",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("${correctAnswers.length*4+((attempted.length-correctAnswers.length)*-1)}",style: const TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.blue),),
                          ),
                          Text("Out of ${l.length*4}",style:  TextStyle(fontWeight: FontWeight.w700,color: Colors.grey.shade500),),
                          const SizedBox(height: 20,),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(CupertinoIcons.hourglass,color: Colors.orange,),
                              Text("Time Taken: ${controller.minute.value} minutes: ${controller.seconds.value%60} seconds"),
                            ],
                          ),
                          const SizedBox(height: 20,),
                           Container(
                             width: 400,
                             height: 10,
                             child:
                             LinearProgressIndicator(
                               borderRadius: BorderRadius.circular(20),
                               value: (correctAnswers.length/attempted.length).clamp(0, 1),
                               valueColor:const AlwaysStoppedAnimation<Color>(Colors.blue),
                             ),
                          ),
                          const SizedBox(height: 20,),
                          Text("Accuracy ${((correctAnswers.length/attempted.length)*100).toStringAsFixed(2)} %",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.grey.shade600),),
                          const SizedBox(height: 40,),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 150),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.question_circle_fill,size:28,color: Colors.purpleAccent.shade200,),
                                          const SizedBox(width: 10,),
                                          const Text("Total Questions ",style: TextStyle(fontWeight: FontWeight.w800),),
                                        ],
                                      ),
                                      Text("${l.length}",style: const TextStyle(fontWeight: FontWeight.w800)),
                                    ],
                                  ),
                                  const SizedBox(height: 25,),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                      const Row(
                                        children: [
                                          Icon(CupertinoIcons.checkmark_alt_circle_fill,size:28,color: Colors.green,),
                                          SizedBox(width: 10,),
                                          Text("Correct Answers ",style: TextStyle(fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                      Text("${correctAnswers.length}",style: const TextStyle(fontWeight: FontWeight.w800))
                                    ],
                                  ),
                                  const SizedBox(height: 25,),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(CupertinoIcons.xmark_circle_fill,size:28,color: Colors.redAccent,),
                                          SizedBox(width: 10,),
                                          Text("Incorrect Answers ",style: TextStyle(fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                      Text("${attempted.length-correctAnswers.length}",style: const TextStyle(fontWeight: FontWeight.w800))
                                    ],
                                  ),
                                  const SizedBox(height: 25,),
                                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(CupertinoIcons.exclamationmark_circle_fill,size:28,color: Colors.grey,),
                                          SizedBox(width: 10,),
                                          Text("Unattempted Questions ",style: TextStyle(fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                      Text("${l.length-attempted.length}",style: const TextStyle(fontWeight: FontWeight.w800))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 150),
                            child:
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SolutionPage()));},
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(border: Border.all(color:  Colors.blue),borderRadius: BorderRadius.circular(5)),
                                height: 50,
                                child:
                                 const Text(
                                  "View Solutions",
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                              ),
                            ),
                          )


                        ],
                      ),
                    ),
                  ),
               ),
             ),
           )
                  :
              Center(
                  child: Card(
                    child: Container(
                      color: Colors.white,

                      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
                      child:
                      SingleChildScrollView(
                        child:
                        Column(
                          children: [
                            const Text("Score",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("${correctAnswers.length*4+((attempted.length-correctAnswers.length)*-1)}",style: const TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.blue),),
                            ),
                            Text("Out of ${l.length*4}",style:  TextStyle(fontWeight: FontWeight.w700,color: Colors.grey.shade500),),
                            const SizedBox(height: 20,),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(CupertinoIcons.hourglass,color: Colors.orange,),
                                Text("Time Taken: ${controller.minute.value} minutes: ${controller.seconds.value%60} seconds"),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              width: 400,
                              height: 10,
                              child:
                              LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(20),
                                value: (correctAnswers.length/attempted.length).clamp(0, 1),
                                valueColor:const AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Text("Accuracy ${((correctAnswers.length/attempted.length)*100).toStringAsFixed(2)} %",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.grey.shade600),),
                            const SizedBox(height: 40,),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.question_circle_fill,size:28,color: Colors.purpleAccent.shade200,),
                                          const SizedBox(width: 10,),
                                          const Text("Total Questions ",style: TextStyle(fontWeight: FontWeight.w800),),
                                        ],
                                      ),
                                      Text("${l.length}",style: const TextStyle(fontWeight: FontWeight.w800)),
                                    ],
                                  ),
                                  const SizedBox(height: 25,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(CupertinoIcons.checkmark_alt_circle_fill,size:28,color: Colors.green,),
                                          SizedBox(width: 10,),
                                          Text("Correct Answers ",style: TextStyle(fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                      Text("${correctAnswers.length}",style: const TextStyle(fontWeight: FontWeight.w800))
                                    ],
                                  ),
                                  const SizedBox(height: 25,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(CupertinoIcons.xmark_circle_fill,size:28,color: Colors.redAccent,),
                                          SizedBox(width: 10,),
                                          Text("Incorrect Answers ",style: TextStyle(fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                      Text("${attempted.length-correctAnswers.length}",style: const TextStyle(fontWeight: FontWeight.w800))
                                    ],
                                  ),
                                  const SizedBox(height: 25,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(CupertinoIcons.exclamationmark_circle_fill,size:28,color: Colors.grey,),
                                          SizedBox(width: 10,),
                                          Text("Unattempted Questions ",style: TextStyle(fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                      Text("${l.length-attempted.length}",style: const TextStyle(fontWeight: FontWeight.w800))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 50),
                              child:
                              GestureDetector(
                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SolutionPageResp(solutionPage: SolutionPage(), solutionMobileView: SolutionMobileView())));},
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(border: Border.all(color:  Colors.blue),borderRadius: BorderRadius.circular(5)),
                                  height: 50,
                                  child:
                                  const Text(
                                    "View Solutions",
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                                ),
                              ),
                            )


                          ],
                        ),
                      ),
                    ),
                  ),
                ),


        ),
      );
  }
}