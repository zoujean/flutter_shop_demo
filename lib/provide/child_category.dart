import 'package:flutter/material.dart';
import '../model/category.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/categoryGoodsList.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChildCategory with ChangeNotifier{
  List list = []; // 左侧列表
  List<CategoryListData> goodsList = []; // 右侧列表
  List<BxMallSubDtoModel> childCategoryList = []; //商品列表
  int listIndex = 0; //大类索引值
  int childIndex = 0; //子类索引值
  String categoryId = '4'; //大类ID
  String subId =''; //小类ID 
  int page = 1;  //列表页数，当改变大类或者小类时进行改变
  String noMoreText = '加载完成'; //显示更多的标识

  setLeftList(List leftList) {
    list = leftList;
    notifyListeners();
  }
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
  changeListIndex(int index)async{
    listIndex = index;
    var childList = list[index].bxMallSubDto;
    var categoryId = list[index].mallCategoryId;
    BxMallSubDtoListModel _childList = BxMallSubDtoListModel.fromJson(childList);
    getChildCategory(_childList.data, categoryId);
    await getGoodList();
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

  getGoodsList(int page, List<CategoryListData> list){
    if(page == 1){
      goodsList = [];
    }
    if (list != null) {
      goodsList.addAll(list);
    }
    notifyListeners();
  }

  getGoodList()async{
    print(page);
    var data={
      'categoryId': categoryId,
      'categorySubId': subId,
      'page': page
    };
    var val = await httpRequest('getMallGoods',formData:data);
    var res = json.decode(val.toString());
    CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(res);
    getGoodsList(page, goodsList.data);
    if(goodsList.data==null){
      changeNoMore('没有更多了');
      Fluttertoast.showToast(
        msg: '没有更多了',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(26)
      );
      reducePage();
    } else {
      changeNoMore('加载完成');
    }
  }
}
