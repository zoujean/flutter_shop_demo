import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../model/categoryGoodsList.dart';
import '../provide/category_goods_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>{

  void getGoodList()async{
    var page = Provide.value<ChildCategory>(context).page;
    var data={
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': page
    };
    var val = await httpRequest('getMallGoods',formData:data);
    var res = json.decode(val.toString());
    CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(res);
    Provide.value<CategoryGoodsListProvide>(context).getGoodsList(page, goodsList.data);
    if(goodsList.data==null){
      Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      Fluttertoast.showToast(
        msg: '没有更多了',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(26)
      );
      if(page > 1){
        Provide.value<ChildCategory>(context).reducePage();
      }
    } else {
      Provide.value<ChildCategory>(context).changeNoMore('加载完成');
    }
  }

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
            LeftCategoryNav(getGoodList:getGoodList),
            Column(
              children: <Widget>[
                RightCategoryNav(getGoodList:getGoodList),
                CategoryGoodsList(getGoodList:getGoodList)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget{
  final Function getGoodList;
  LeftCategoryNav({Key key,this.getGoodList}):super(key:key);
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
      _setProvideData(0);
    });
  }
  void _setProvideData(int index){
    var childList = list[index].bxMallSubDto;
    var categoryId = list[index].mallCategoryId;
    BxMallSubDtoListModel _childList = BxMallSubDtoListModel.fromJson(childList);
    Provide.value<ChildCategory>(context).getChildCategory(_childList.data, categoryId);
    widget.getGoodList();
  }

  Widget _leftInkWell(int index){
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });

        _setProvideData(index);
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
  final Function getGoodList;
  RightCategoryNav({Key key,this.getGoodList}):super(key:key);

  @override
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
                return _rightInkWell(index, _list[index]);
              },
            );
          },
        ),
      )
    );
  }

  Widget _rightInkWell(int index, BxMallSubDtoModel item) {
    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        widget.getGoodList();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28),color: index==Provide.value<ChildCategory>(context).childIndex ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  final Function getGoodList;
  CategoryGoodsList({Key key,this.getGoodList}):super(key:key);

  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  // List list = [];

  // @override
  // void initState() {
  //   _getGoodList();
  //   super.initState();
  // }
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _easyRefreshHeaderKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _easyRefreshFooterKey = new GlobalKey<RefreshFooterState>();


  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: Container(
        width: ScreenUtil().setWidth(570),
        // height: ScreenUtil().setHeight(980),
        // child: ListView.builder(
        //   scrollDirection: Axis.vertical,
        //   itemCount: list.length,
        //   itemBuilder: (context, index){
        //     return _listWidget(index);
        //   },
        // ),

        // child: ListView(
        //   children: <Widget>[
        //     Provide<CategoryGoodsListProvide>(
        //       builder: (context, child, data){
        //         List list = data.goodsList;
        //         return _listWidget2(list);
        //       },
        //     )
        //   ],
        // ),

        child: EasyRefresh(
          key: _easyRefreshKey,
          child: ListView(
            children: <Widget>[
              Provide<CategoryGoodsListProvide>(
                builder: (context, child, data){
                  List list = data.goodsList;
                  return _listWidget2(list);
                },
              )
            ],
          ),
          loadMore: ()async{
            var goodsList = Provide.value<CategoryGoodsListProvide>(context).goodsList;
            if(goodsList.length > 0){
              Provide.value<ChildCategory>(context).addPage();
              await widget.getGoodList();
            } else {
              Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
            }
          },
          refreshFooter: ClassicsFooter(
            key: _easyRefreshFooterKey,
            bgColor:Colors.white,
            textColor:Colors.pink,
            moreInfoColor: Colors.pink,
            // showMore:true,
            loadText: '上拉加载',
            noMoreText:Provide.value<ChildCategory>(context).noMoreText,
            // moreInfo:'加载中',
            loadReadyText:'释放加载更多',
            loadingText: '加载中',
          ),
        )
      )
    );
  }

/*
  Widget _listWidget(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(285),
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
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }
  Widget _goodsName(int index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(270),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28))
      ),
    );
  }
  Widget _goodsPrice(int index){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(280),
      child: Row(
        children: <Widget>[
          Text(
            '￥${list[index].presentPrice}',
            style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(30))
          ),
          Text(
            '￥${list[index].oriPrice}',
            style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
*/
  Widget _listWidget2(List list) {
    if(list.length > 0) {
      List<Widget> listWidget = list.map((val){
        return InkWell(
          onTap: (){},
          child: Container(
            width: ScreenUtil().setWidth(285),
            padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
            ),
            child: Column(
              children: <Widget>[
                Image.network(val.image,width: ScreenUtil().setWidth(200)),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding: EdgeInsets.only(left: 5.0,right: 5.0),
                  height: ScreenUtil().setHeight(75),
                  alignment: Alignment.topLeft,
                  child: Text(
                    val.goodsName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.pink)
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(140),
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        '￥${val.presentPrice}',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30))
                      ),
                    ),
                    Text(
                      '￥${val.oriPrice}',
                      style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        children: listWidget,
      );
    } else {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 5.0),
        child: Text(
          '没有更多数据了',
          style: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.black54),
        ),
      );
    }
  }
}
