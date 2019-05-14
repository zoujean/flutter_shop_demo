import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import '../../provide/cart.dart';

class CountController extends StatelessWidget{
  const CountController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var goodInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodInfo.goodsId;
    var goodsName = goodInfo.goodsName;
    var price = goodInfo.presentPrice;
    var image = goodInfo.image1;
    // var count = Provide.value<DetailsInfoProvide>(context).count;

    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(750),
      // height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1,color: Colors.black26)),
        color: Colors.white
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text('购买数量'),
                ),
                InkWell(
                  onTap: (){Provide.value<DetailsInfoProvide>(context).changeController('hide');},
                  child: Container(
                    padding: EdgeInsets.only(top: 2,right: 2,left: 5,bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))
                    ),
                    child: Icon(Icons.close, color: Colors.white,size: 15,),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 15),
            child: Row(
              children: <Widget>[
                Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    onTap: (){Provide.value<DetailsInfoProvide>(context).addOrReduceAction('reduce');},
                    child: Text('－', style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(18))),
                  ),
                ),
                Provide<DetailsInfoProvide>(
                  builder: (context,child, val){
                    var count = val.count;
                    return Container(
                      width: 32,
                      height: 20,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 5,right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.black26),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('$count', style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
                    );
                  },
                ),
                Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    onTap: (){Provide.value<DetailsInfoProvide>(context).addOrReduceAction('add');},
                    child: Text('＋', style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(18))),
                  ),
                ),
                Container(
                  width: 100,
                  height: 26,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Provide<DetailsInfoProvide>(
                    builder: (context, child, val){
                      var count = val.count;
                      return InkWell(
                        onTap: ()async{
                          print(count);
                          await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, image);
                          Provide.value<DetailsInfoProvide>(context).changeController('hide');
                        },
                        child: Text('确定加入购物车', style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20)),),
                      );
                    },
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
