import 'package:flutter/material.dart';

class WishListRegisterModel extends ChangeNotifier {
  int currentStep = 0;

  List<Step> mySteps(){
    List<Step> steps = [
      Step(
        title: Text('step 1'),
        content: TextField(),
        isActive: currentStep == 0,
      ),
      Step(
        title: Text('step 2'),
        content: TextField(),
        isActive: currentStep == 1,
      ),
      Step(
        title: Text('step 3'),
        content: TextField(),
        isActive: currentStep == 2,
      ),
    ];
    notifyListeners();
    return steps;
  }

  Future toNextStep() async {
    if(currentStep < mySteps().length -1 ) {
      currentStep += currentStep;
      print(currentStep);
    }else{
      print('finish');
    }
    notifyListeners();
  }

  Future toPreviousStep() async {
    if(currentStep > 0) {
      currentStep -= currentStep;
      print(currentStep);
    } else {
      currentStep = 0;
    }
    notifyListeners();
  }

}