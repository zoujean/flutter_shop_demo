import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  const CartBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          selectAllBtn(context),
          allPriceArea(context),
          goButton(context)
        ],
      ),
    );
  }

  Widget selectAllBtn(context){
    return Provide<CartProvide>(
      builder: (context,child,val){
        bool isAllCheck = val.isAllCheck;
        return Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                value: isAllCheck,
                activeColor: Colors.pink,
                onChanged: (bool val){
                  Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
                },
              ),
              Text('全选')
            ],
          ),
        );
      },
    );
  }
  Widget allPriceArea(context){
    return Provide<CartProvide>(
      builder: (context,child,val){
        double allPrice = val.allPrice;
        return Container(
          width: ScreenUtil().setWidth(430),
          alignment: Alignment.centerRight,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                      '合计:',
                      style: TextStyle(fontSize: ScreenUtil().setSp(32))
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0, right: 10.0),
                    child: Text(
                      '￥$allPrice',
                      style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(32))
                    ),
                  )
                ],
              ),
              Container(
                width: ScreenUtil().setWidth(430),
                alignment: Alignment.centerRight,
                child: Text(
                  '满10元免配送费，预购免配送费',
                  style: TextStyle(color: Colors.black38, fontSize: ScreenUtil().setSp(22))
                ),
              )
            ],
          ),
        );
      },
    );
  }
  Widget goButton(context){
    return Provide<CartProvide>(
      builder: (context,child,val){
        int allGoodsCount = val.allGoodsCount;
        return Container(
          width: ScreenUtil().setWidth(150),
          padding: EdgeInsets.only(left: 5),
          margin: EdgeInsets.all(5),
          child: InkWell(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(3.0)
              ),
              child: Text(
                '结算($allGoodsCount)',
                style: TextStyle(color: Colors.white)
              ),
            ),
          ),
        );
      },
    );
  }
}
