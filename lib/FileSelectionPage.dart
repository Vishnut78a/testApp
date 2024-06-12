

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/controller/Controller.dart';
import 'package:untitled3/helperFile.dart';
import 'package:untitled3/main.dart';
import 'package:untitled3/model/mobileView.dart';

import 'model/TestModel.dart';



class FileSelectionPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SelectFile();

  }

}
class SelectFile extends StatelessWidget{
  Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    return
      Scaffold(
        appBar: AppBar(title: const Text("Test"),),
        body:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:
              TextButton(
                  onPressed: (){
                    getTestModelListFromSaved();
                    showModalBottomSheet(
                        context: context,
                        builder: (context)=>
                            Container(
                              height: size.height*.5,
                              child:
                              ListView.builder(
                                  itemCount: savedTestFiles.length,
                                  itemBuilder: (context,index)=>
                                       ListTile(
                                         onTap: ()async{
                                           var i = box.get(savedTestFiles.elementAt(index) );
                                           var j = jsonEncode(i);
                                           print("wwwwwwww");
                                           print(i.runtimeType);
                                           print(j.runtimeType);
                                           print(i);
                                           print(j);
                                           var decodedData = await jsonDecode(j);

                                           l = listOfQandA(decodedData );
                                           Navigator.pushReplacement(
                                               context,
                                               MaterialPageRoute(
                                                   builder: (context)=>MyApp(mobileView: MobileView(), myHomePage: MyHomePage(title: ""))));
                                         },
                                         title: Text(savedTestFiles.elementAt(index)),)),

                            )
                    );
                  },
                  child: const Text("Re-Attempt")),),
            Center(
              child:
              TextButton(
                  onPressed: ()async{
                    FilePickerResult? result = await FilePicker.platform.pickFiles();

                   // controller.jsontTestFile.value = File(result!.files.single.path!);


                  //  var s = await rootBundle.loadString(controller.jsontTestFile.value.path);

                    if(result!=null){
                   //   controller.jsontTestFile.value = File(result.files.single.path!);
                     // var fileContent =  File(controller.jsontTestFile.value.path).readAsStringSync();
                      //ontroller.jsonDecodedFile.value = fileContent;
                      if(kIsWeb){
                        final Uint8List bytes = result.files.single.bytes!;
                        String jsonString = utf8.decode(bytes);
                        f=jsonString;
                      }
                      else{
                        controller.jsontTestFile.value = File(result.files.single.path!);
                        var fileContent =  File(controller.jsontTestFile.value.path).readAsStringSync();
                        f=fileContent;
                        fileName=result.files[0].name;
                        
                      }

                      var i = await getTestModelList();
                      print( "dsf:${controller.jsonDecodedFile.value.isEmpty}");


                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>MyApp(mobileView: MobileView(), myHomePage: MyHomePage(title: ""))));
                    }
                    else{
                      print("Error");
                    }
                  },
                  child: const Text("data")),
            ),
          ],
        ),


      );
  }
  getTestModelListFromSaved(){
    for( String  i in box.keys){
      savedTestFiles.add(i);
    }



  }
  getTestModelList()async{
    // String fileContent =  File(widget.controller.jsontTestFile.value.path).readAsStringSync();
    //var s = await rootBundle.loadString(fileContent);
    //var s = await rootBundle.loadString("assets/data/test.json");
    //print("d");
    //print("${widget.controller.jsonDecodedFile.value}");
    //print( "dsf:${widget.controller.jsonDecodedFile.value.isEmpty}");

    Map<String,dynamic> decodedData = await jsonDecode(f);
    print("d");
    print(decodedData);
    l = listOfQandA(decodedData['data']['sections'][0]['questions'] );
    box.containsKey(fileName)?print("ffffffff${box.get(fileName)}"):box.put(fileName, decodedData['data']['sections'][0]['questions']);
    controller.li.value=true;


  }
}