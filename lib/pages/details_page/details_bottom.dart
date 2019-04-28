import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  const DetailsBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(80),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: (){},
              child: Container(
                width: ScreenUtil().setWidth(110),
                alignment: Alignment.center,
                child: Icon(Icons.shopping_cart, color: Colors.red, size: 32,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: Container(
                width: ScreenUtil().setWidth(320),
                color: Colors.green,
                alignment: Alignment.center,
                child: Text('加入购物车', style: TextStyle(color: Colors.white),),
              ),
            ),
            InkWell(
              onTap: (){},
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