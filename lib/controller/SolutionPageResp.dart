

import 'package:flutter/cupertino.dart';
import 'package:untitled3/SolutionMobileView.dart';

import '../SolutionPage.dart';

class SolutionPageResp extends StatelessWidget{
  SolutionPage solutionPage;
  SolutionMobileView solutionMobileView;

  SolutionPageResp({required this.solutionPage,required this.solutionMobileView});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
        LayoutBuilder(builder: (context,constraints)
        {
          if(constraints.maxWidth>=768){
            return solutionPage;
          }
          else{
            return solutionMobileView;
          }
        });
  }
}