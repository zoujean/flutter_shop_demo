import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/details_info.dart';

import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_web.dart';
import './details_page/details_bottom.dart';
import './details_page/count_controller.dart';


class DetailsPage extends StatelessWidget{
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot){
          Provide.value<DetailsInfoProvide>(context).initState();
          if(snapshot.hasData){
            return Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                      DetailsWeb()
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                ),
                Provide<DetailsInfoProvide>(
                  builder: (context, child, val){
                    if(val.countController){
                      return Positioned(
                        bottom: 0,
                        left: 0,
                        child: CountController(),
                      );
                    }else{
                      return Text('');
                    }
                  },
                )
              ],
            );
          }else{
            return Text('加载中');
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context)async{
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '加载完成';
  }
}