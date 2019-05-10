import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDtoModel> childCategoryList = []; //商品列表
  int listIndex = 0; //大类索引值
  int childIndex = 0; //子类索引值
  String categoryId = '4'; //大类ID
  String subId =''; //小类ID 
  int page = 1;  //列表页数，当改变大类或者小类时进行改变
  String noMoreText = '加载完成'; //显示更多的标识

  //点击大类时更换
  getChildCategory(List<BxMallSubDtoModel> list, String id) {
    categoryId = id;
    childIndex = 0;
    page=1;
    noMoreText = '加载完成'; 
    subId=''; //点击大类时，把子类ID清空
    BxMallSubDtoModel all = BxMallSubDtoModel();
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变大类索引
  changeListIndex(int index){
    listIndex = index;
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(int index, String id){
    childIndex = index;
    subId = id;
    page=1;
    noMoreText = '加载完成'; 
    notifyListeners();
  }

  //增加Page的方法
  addPage(){
    page++;
  }
  reducePage(){
    page--;
  }

  //改变noMoreText数据  
  changeNoMore(String text){
    noMoreText=text;
    notifyListeners();
  }
}
