import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../model/categoryGoodsList.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>{
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget{
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav>{
  List list = [];
  int listIndex = 0;
  
  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:list.length,
        itemBuilder: (context,index){
          return _leftInkWell(index);
        },
      ),
    );
  }

  void _getCategory()async{
    await httpRequest('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category= CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      // 右侧子类初始化赋值
      var childList = list[0].bxMallSubDto;
      BxMallSubDtoListModel _childList = BxMallSubDtoListModel.fromJson(childList);
      Provide.value<ChildCategory>(context).getChildCategory(_childList.data);
    });
  }

  Widget _leftInkWell(int index){
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });

        var childList = list[index].bxMallSubDto;
        BxMallSubDtoListModel _childList = BxMallSubDtoListModel.fromJson(childList);
        Provide.value<ChildCategory>(context).getChildCategory(_childList.data);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding:EdgeInsets.only(left:10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: (index==listIndex)?Color.fromRGBO(236, 238, 239, 1.0):Colors.white,
          border:Border(
            bottom:BorderSide(width: 1,color:Colors.black12)
          )
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize:ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Provide<ChildCategory>(
          builder: (context, child, childCategory) {
            List _list = childCategory.childCategoryList;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _list.length,
              itemBuilder: (context, index){
                return _rightInkWell(_list[index]);
              },
            );
          },
        ),
      )
    );
  }

  Widget _rightInkWell(BxMallSubDtoModel item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);

  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  List list = [];

  @override
  void initState() {
    _getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(1000),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index){
          return _ListWidget(index);
        },
      ),
    );
  }

  void _getGoodList()async{
    var data={
      'categoryId':'4',
      'categorySubId':"",
      'page':1
    };
    await httpRequest('getMallGoods',formData:data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      setState(() {
        list = goodsList.data;
      });
    });
  }

  Widget _ListWidget(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
        ),
        child: Column(
          children: <Widget>[
            _goodsImage(index),
            _goodsName(index),
            _goodsPrice(index)
          ],
        ),
      ),
    );
  }

  Widget _goodsImage(int index){
    return build(context);
  }
  Widget _goodsName(int index){
    return build(context);
  }
  Widget _goodsPrice(int index){
    return build(context);
  }
}
