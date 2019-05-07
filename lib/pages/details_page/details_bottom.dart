import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import '../../provide/cart.dart';
import '../../routers/application.dart';
import '../../provide/currentIndex.dart';

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
                // Application.router.navigateTo(context, '/cart');
                Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                Navigator.pop(context);
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(110),
                    alignment: Alignment.center,
                    child: Icon(Icons.shopping_cart, color: Colors.red, size: 32,),
                  ),
                  Provide<CartProvide>(
                    builder: (context, child, val){
                      int goodsCount = val.allGoodsCount;
                      if(goodsCount > 0){
                        return Positioned(
                          top: 0,
                          right: 5,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5,3,5,3),
                            decoration: BoxDecoration(
                              color:Colors.pink,
                              border:Border.all(width: 2,color: Colors.white),
                              borderRadius: BorderRadius.circular(12.0)
                            ),
                            child: Text(
                              '$goodsCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16)
                              ),
                            ),
                          ),
                        );
                      }else{
                        return Text('');
                      }
                    },
                  )
                ],
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