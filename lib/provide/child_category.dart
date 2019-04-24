import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDtoModel> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';

  //点击大类时更换
  getChildCategory(List<BxMallSubDtoModel> list, String id) {
    categoryId = id;
    childIndex = 0;
    BxMallSubDtoModel all = BxMallSubDtoModel();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index){
    childIndex = index;
    notifyListeners();
  }
}
