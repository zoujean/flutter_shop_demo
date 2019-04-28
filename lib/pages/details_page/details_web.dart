import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsWeb extends StatelessWidget {
  const DetailsWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Provide<DetailsInfoProvide>(
      builder: (context, child, data){
        if(data.isLeft){
          return Container(
            child: Html(
              data: goodsDetail,
            ),
          );
        }else{
          return Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(200),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text('暂时还没有评论喔！',style: TextStyle(color: Colors.black45),),
          );
        }
      },
    );
  }
}