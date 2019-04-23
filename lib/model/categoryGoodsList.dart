class CategoryGoodsListModel {
  String code;
  String message;
  List<CategoryListData> data;

  CategoryGoodsListModel({this.code, this.message, this.data});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoryListData>();
      json['data'].map((item) => data.add(CategoryListData.fromJson(item)));
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if(this.data != null) {
      data['data'] = this.data.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class CategoryListData {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  CategoryListData({
    this.image,
    this.oriPrice,
    this.presentPrice,
    this.goodsName,
    this.goodsId
  });

  CategoryListData.fromJson(Map<String, dynamic> json){
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}
