import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';
import '../provide/currentIndex.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('购物车'),),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot){
          // List cartList = Provide.value<CartProvide>(context).cartList;
          if(snapshot.hasData){
            return Provide<CartProvide>(
              builder: (context, child, val){
                List cartList = val.cartList;
                if(cartList!=null && cartList.length>0){
                  return Stack(
                    children: <Widget>[
                      Provide<CartProvide>(
                        builder: (context, child, data){
                          cartList= data.cartList;
                          return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (context, index){
                              return ListTile(
                                title: CartItem(cartList[index]),
                              );
                            },
                          );
                        }
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: CartBottom(),
                      )
                    ],
                  );
                }else{
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('购物车空空如也，快去挑选商品吧', style: TextStyle(color: Colors.black45)),
                        InkWell(
                          onTap: (){Provide.value<CurrentIndexProvide>(context).changeIndex(0);},
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            width: ScreenUtil().setWidth(220),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius: BorderRadius.circular(2)
                            ),
                            child: Text('随便逛逛', style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            );
          }else{
            return Text('正在加载');
          }
        },
      ),
    );
  }
  Future _getCartInfo(BuildContext context)async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return '加载完成';
  }
}