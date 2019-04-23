import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDtoModel> childCategoryList = [];

  getChildCategory(List<BxMallSubDtoModel> list) {
    BxMallSubDtoModel all = BxMallSubDtoModel();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
}
