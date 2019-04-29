import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import './cart_page/cart_item.dart';

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
          if(snapshot.hasData){
            List cartList = Provide.value<CartProvide>(context).cartList;
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: CartItem(cartList[index]),
                );
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