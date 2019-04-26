import 'package:flutter/material.dart';
import '../model/details.dart';
// import '../service/service_method.dart';
// import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo;

  //从后台获取商品信息

  // getGoodsInfo(String id){
  //   var formData = { 'goodId':id, };
  //   httpRequest('getGoodDetailById',formData:formData).then((val){
  //     var responseData= json.decode(val.toString());
  //     goodsInfo=DetailsModel.fromJson(responseData);
  //     notifyListeners();
  //   });
  // }
  setGoodsInfo(DetailsModel data){
    goodsInfo = data;
  }
}
