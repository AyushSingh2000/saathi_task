import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier{
  bool _isdisposed = false;
  bool _isLoading = false;

  get isLoading => _isLoading;


  @override
  void notifyListeners() {
    if(!_isdisposed){
      super.notifyListeners();
    }
  }
  setLoading(bool val){
    _isLoading=val;
    notifyListeners();
  }


  @override
  void dispose() {
    _isdisposed=true;
    super.dispose();
  }


}