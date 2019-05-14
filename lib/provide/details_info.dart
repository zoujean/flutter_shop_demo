import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;
  bool countController = false;
  int count = 1;

  initState(){
    count = 1;
    isLeft = true;
    isRight = false;
    countController = false;
    notifyListeners();
  }
  //从后台获取商品信息

  getGoodsInfo(String id)async{
    var formData = { 'goodId':id, };
    var val =await httpRequest('getGoodDetailById',formData:formData);
    var responseData= json.decode(val.toString());
    goodsInfo=DetailsModel.fromJson(responseData);
    notifyListeners();
  }

  changeLeftAndRight(String changeState){
    if(changeState == 'left'){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
  changeController(String changeState){
    if(changeState == 'show'){
      countController = true;
    }else{
      countController = false;
    }
    notifyListeners();
  }
  addOrReduceAction(String todo){
    if(todo=='add'){
      count++;
    }else if(count>1){
      count--;
    }
    notifyListeners();
  }
}
