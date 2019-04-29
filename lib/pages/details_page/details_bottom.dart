import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import '../../provide/cart.dart';
import '../../routers/application.dart';

class DetailsBottom extends StatelessWidget {
  const DetailsBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var goodInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodInfo.goodsId;
    var goodsName = goodInfo.goodsName;
    var count = 1;
    var price = goodInfo.presentPrice;
    var image = goodInfo.image1;

    return Container(
      child: Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(80),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: (){
                Application.router.navigateTo(context, '/cart');
              },
              child: Container(
                width: ScreenUtil().setWidth(110),
                alignment: Alignment.center,
                child: Icon(Icons.shopping_cart, color: Colors.red, size: 32,),
              ),
            ),
            InkWell(
              onTap: ()async{
                await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, image);
              },
              child: Container(
                width: ScreenUtil().setWidth(320),
                color: Colors.green,
                alignment: Alignment.center,
                child: Text('加入购物车', style: TextStyle(color: Colors.white),),
              ),
            ),
            InkWell(
              onTap: ()async{
                await Provide.value<CartProvide>(context).remove();
              },
              child: Container(
                width: ScreenUtil().setWidth(320),
                alignment: Alignment.center,
                color: Colors.red,
                child: Text('立即购买', style: TextStyle(color: Colors.white)),
              ),
            ),
          ]
        ),
      ),
    );
  }
}