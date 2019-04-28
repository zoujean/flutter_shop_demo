import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea  extends StatelessWidget {
  const DetailsTopArea ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<DetailsInfoProvide>(
        builder: (context, child, val){
          var goodInfo = val.goodsInfo.data.goodInfo;
          if(goodInfo != null){
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(2.0),
              child: Column(
                children: <Widget>[
                  _goodsImage(goodInfo.image1),
                  _goodsName(goodInfo.goodsName),
                  _goodsNum(goodInfo.goodsSerialNumber),
                  _goodsPrice(goodInfo.presentPrice, goodInfo.oriPrice),
                ],
              ),
            );
          }else{
            return Text('正在加载中...');
          }
        },
      ),
    );
  }

  Widget _goodsImage(url){
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
      height: ScreenUtil().setHeight(760)
    );
  }

  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        maxLines: 1,
        style: TextStyle(fontSize: ScreenUtil().setSp(30))
      ),
    );
  }

  Widget _goodsNum(num){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号:$num',
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  Widget _goodsPrice(presentPrice, oriPrice){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(40)
            ),
          ),
          Text(
            '市场价:￥$oriPrice',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
          )
        ],
      ),
    );
  }
}