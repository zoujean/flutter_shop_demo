import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryListData> goodsList = [];

  getGoodsList(int page, List<CategoryListData> list){
    if(page == 1){
      goodsList = [];
    }
    if (list != null) {
      goodsList.addAll(list);
    }
    notifyListeners();
  }
}
