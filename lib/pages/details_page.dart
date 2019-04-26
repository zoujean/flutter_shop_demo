import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';

import '../service/service_method.dart';
import 'dart:convert';

import './details_page/details_top_area.dart';

import '../model/details.dart';

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
          if(snapshot.hasData){
            // Provide.value<DetailsInfoProvide>(context).setGoodsInfo(snapshot.data);
            return Container(
              child: Column(
                children: <Widget>[
                  // DetailsTopArea(),
                ],
              ),
            );
          }else{
            return Text('加载中');
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context)async{
    var formData = { 'goodId':goodsId, };
    var val = await httpRequest('getGoodDetailById',formData:formData);
    var responseData= json.decode(val.toString());
    DetailsModel goodsInfo = DetailsModel.fromJson(responseData);
    return goodsInfo;
  }
}