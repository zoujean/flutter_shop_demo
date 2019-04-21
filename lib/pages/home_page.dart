import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     getHttp();
//     return Scaffold(
//       body:Center(
//         child: Text('商城首页'),
//       )
//     );
//   }

//   void getHttp()async{
//     try{
//       Response response;
//       response = await Dio().get(
//         "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女",
//         //  queryParameters:data
//       );
//       return print(response);
//     }catch(e){
//       return print(e);
//     }
//   }

// }

// class HomePage extends StatefulWidget{
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController typeController = TextEditingController();
//   String showText = '欢迎你来到美好人间';
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(title: Text('美好人间'),),
//       body: SingleChildScrollView(
//         child: Container(
//           height: 1000,
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 controller: typeController,
//                 decoration: InputDecoration(
//                   labelText: '类型',
//                   helperText: '请输入你喜欢的类型',
//                   contentPadding: EdgeInsets.all(10),
//                   hintText: '请输入',
//                   // hintStyle: TextStyle(height: 2)
//                 ),
//                 autofocus: false,
//               ),
//               RaisedButton(
//                 onPressed: _choiceAction,
//                 child: Text('选择完毕'),
//               ),
//               Text(
//                 showText,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _choiceAction() {
//     print('请选择你喜欢的类型...');
//     // if(typeController.text.toString() == '') {
//     //   showDialog(
//     //     context: context,
//     //     builder: (context)=>AlertDialog(title: Text('类型不能为空'),)
//     //   );
//     // } else {
//       getHttp(typeController.text.toString()).then((val){
//         setState(() {
//           showText = val['data']['name'].toString();
//         });
//       });
//     // }
//   }

//   Future getHttp(String typeText)async{
//     try{
//       Response response;
//       var data = {"name": typeText};
//       // response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian", queryParameters: data);
//       response = await Dio().post("https://www.easy-mock.com/mock/5cb57d8b58a14f2b2173886f/shop/baixing/dabaojian", queryParameters: data);
//       return response.data;
//     }catch(e){
//       return print(e);
//     }
//   }
// }

// import '../config/httpHeaders.dart';

// class HomePage extends StatefulWidget{
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>{
//   String showText = '还没有请求数据';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('请求远程数据'),),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               RaisedButton(
//                 onPressed: _sendRequest,
//                 child: Text('发送请求'),
//               ),
//               Text(showText)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _sendRequest() {
//     print('开始请求数据...');
//     getHttp().then((val){
//       setState(() {
//         showText = val['data'].toString();
//       });
//     });
//   }

//   Future getHttp()async{
//     try{
//       Response response;
//       Dio dio = new Dio();
//       dio.options.headers = httpHeaders;
//       response = await dio.post('https://time.geekbang.org/serv/v1/column/newAll');
//       print(response);
//       return response.data;
//     }catch(e){
//       return print(e);
//     }
//   }
// }

import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

int page = 1;
List<Map> hotGoodsList=[];

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  // String homePageContent = '正在获取数据';

  // @override
  // void initState(){
  //   getHomePageContent().then((val){
  //     setState(() {
  //       homePageContent = val.toString();
  //     });
  //   });
  //   super.initState();
  // }
  @override
  bool get wantKeepAlive => true;

 

  @override
  void initState() {
    super.initState();
    page = 1;
    hotGoodsList=[];
    var formPage={'page': page};
    httpRequest('homePageBelowConten',formData:formPage).then((val){
      var data=json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List ).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++; 
      });
    });
    // _getHotGoods();
  }

  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  // GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var formData = {'lon':'115.02932','lat':'35.76189'};

    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      // body: SingleChildScrollView(
      //   child: Text(homePageContent),
      // ),
      body: FutureBuilder(
        future: httpRequest('homePageContext', formData:formData),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast();
            List<Map> navagatorList = (data['data']['category'] as List).cast();
            if(navagatorList.length > 10){
              navagatorList.removeRange(10, navagatorList.length);
            }
            String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['data']['recommend'] as List).cast();
            List floorList = [
              {
                'title': data['data']['floor1Pic']['PICTURE_ADDRESS'],
                'goodsList': (data['data']['floor1'] as List).cast()
              },
              {
                'title': data['data']['floor2Pic']['PICTURE_ADDRESS'],
                'goodsList': (data['data']['floor2'] as List).cast()
              },
              {
                'title': data['data']['floor3Pic']['PICTURE_ADDRESS'],
                'goodsList': (data['data']['floor3'] as List).cast()
              }
            ];
            return EasyRefresh(
              key: _easyRefreshKey,
              child: ListView(
                children: <Widget>[
                  // TopSearch(),
                  SwiperDiy(swiperDataList: swiperDataList),
                  TopNavigator(navagatorList: navagatorList),
                  AdBanner(advertesPicture: advertesPicture),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                  Recommend(recommendList: recommendList),
                  Floors(floorList: floorList),
                  HotGoods()
                ],
              ),
              loadMore: () async{
                print('开始加载更多');
                var formPage={'page': page};
                httpRequest('homePageBelowConten',formData:formPage).then((val){
                  var data=json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List ).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++; 
                  });
                });
              },
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor:Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText:'上拉加载....'
              ),
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }
}

class TopSearch extends StatefulWidget{
  @override
  _TopSearchState createState() => _TopSearchState();
}

class _TopSearchState extends State<TopSearch>{
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Icon(Icons.location_on),
          // TextField(
          //   controller: searchController,
          //   decoration: InputDecoration(
          //     hintText: '搜索喜欢的商品吧'
          //   ),
          //   autofocus: false,
          // ),
          RaisedButton(
            onPressed: _searchProduct,
            child: Text('搜索'),
          )
        ],
      ),
    );
  }

  void _searchProduct() {
    return(print('搜索商品'));
  }
}

class SwiperDiy extends StatelessWidget{
  final List swiperDataList;
  SwiperDiy({Key key, @required this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return new Image.network(swiperDataList[index]['image'], fit: BoxFit.fill,);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget{
  final List navagatorList;
  TopNavigator({Key key, @required this.navagatorList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navagatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item){
    return InkWell(
      onTap: (){
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
}

class AdBanner extends StatelessWidget{
  final String advertesPicture;

  AdBanner({Key key,@required this.advertesPicture}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}

class LeaderPhone extends StatelessWidget{
  final String leaderImage;
  final String leaderPhone;
  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if(await canLaunch(url)){
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Recommend extends StatelessWidget{
  final List recommendList;

  Recommend({Key key, this.recommendList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // height: ScreenUtil().setHeight(410),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
           _titleWidget(),
          _recommendList()
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0,2.0,0,5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5,color: Colors.black12)),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink)
      ),
    );
  }

  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(350),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index){
          return _item(index);
        },
      ),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: (){},
      child: Container(
        // height: ScreenUtil().setHeight(350),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 0.5,color: Colors.black12))
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text("￥${recommendList[index]['mallPrice']}"),
            Text(
              "￥${recommendList[index]['price']}",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            )
          ],
        ),
      )
    );
  }
}

class Floors extends StatelessWidget{
  final List floorList;

  Floors({Key key, this.floorList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: floorList.map((item){
          return _floorItem(context, item);
        }).toList(),
      ),
    );
  }

  Widget _floorItem(BuildContext context, item) {
    return Container(
      child: Column(
        children: <Widget>[
          _floorTitle(context, item['title']),
          _floorContent(context, item['goodsList'])
        ],
      )
    );
  }

  Widget _floorTitle(BuildContext context, title) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(title),
    );
  }

  Widget _floorContent(BuildContext context, goodsList) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _goodsItem(context, goodsList[0]),
              Column(
                children: <Widget>[
                  _goodsItem(context, goodsList[1]),
                  _goodsItem(context, goodsList[2]),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _goodsItem(BuildContext context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){print('点击了楼层商品');},
        child: Image.network(goods['image']),
      ),
    );
  }
}

class HotGoods extends StatefulWidget{
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _hotGoods();
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle(),
          _wrapList()
        ],
      ),
    );
  }

  Widget _hotTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Text('火爆专区'),
    );
  }

  Widget _wrapList() {
    if(hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){print('点击了火爆商品');},
          child: Container(
            width: ScreenUtil().setWidth(372),
            padding: EdgeInsets.all(5.0),
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'],width: ScreenUtil().setWidth(375)),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(26))
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(190),
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text('￥${val['mallPrice']}'),
                    ),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }
}
