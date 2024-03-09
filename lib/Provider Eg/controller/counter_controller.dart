import 'package:flutter/material.dart';
import '../model/counter.dart';

class CounterProvider extends ChangeNotifier{

  Count _incCounter = Count(0);

  Count get counter => _incCounter;

  void increment(){
    _incCounter.value++;
    notifyListeners();
  }


}
