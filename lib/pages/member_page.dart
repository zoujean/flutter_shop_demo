import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
       title: Text('会员中心'),
     ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderArea(),
          _actionList()
        ],
      ) ,
    );
  }
  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pink[100],
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30), 
            child: ClipOval(
              child:Image.network('https://icxpic-10023060.file.myqcloud.com/items/19d0733760fc480f9840ba1c011683c2.png',height: 120,)
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Jean',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                // color:Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _orderArea(){
    return Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          _orderTitle(),
          _orderType()
        ],
      ),
    );
  }
  Widget _orderTitle(){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        onTap: (){print('查看我的全部订单');},
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
  Widget _orderItem(String title){
    return Container(
      width: ScreenUtil().setWidth(187),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.party_mode,
            size: 30,
          ),
          Text(title),
        ],
      ),
    );
  }
  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top:5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top:20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _orderItem('待付款'),
          _orderItem('待发货'),
          _orderItem('待收货'),
          _orderItem('待评价'),
        ],
      ),
    );
  }

  Widget _myListTile(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.insert_emoticon),
        title: Text(title),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于商城'),
        ],
      ),
    );
  }
}