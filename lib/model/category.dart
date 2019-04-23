class CategoryModel {
  List data;
  String code;
  String message;

  CategoryModel({
    this.data,
    this.code,
    this.message
  });

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      data: CategoryBigListModel.formJson(json['data']).data,
      code: json['code'],
      message: json['message']
    );
  }
}


class CategoryBigModel {
  String mallCategoryId; // 类别编号
  String mallCategoryName; // 类别名称
  List<dynamic> bxMallSubDto; // 小类列表
  String image; // 类别图片
  Null comments; // 列表描述

  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.image,
    this.comments
  });

  factory CategoryBigModel.fromJson(dynamic json){
    return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      image: json['image'],
      comments: json['comments'],
    );
  }
}

class CategoryBigListModel {

  List<CategoryBigModel> data;
  CategoryBigListModel(this.data);
  factory CategoryBigListModel.formJson(List json){
    return CategoryBigListModel(
      json.map((item)=>CategoryBigModel.fromJson((item))).toList()
    );
  }
  
}

class BxMallSubDtoModel {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  dynamic comments;

  BxMallSubDtoModel({
    this.mallSubId,
    this.mallCategoryId,
    this.mallSubName,
    this.comments,
  });

  factory BxMallSubDtoModel.fromJson(dynamic json){
    return BxMallSubDtoModel(
      mallSubId: json['mallSubId'],
      mallCategoryId: json['mallCategoryId'],
      mallSubName: json['mallSubName'],
      comments: json['comments'],
    );
  }
}

class BxMallSubDtoListModel {
  List<BxMallSubDtoModel> data;
  BxMallSubDtoListModel(this.data);
  factory BxMallSubDtoListModel.fromJson(List json){
    return BxMallSubDtoListModel(
      json.map((item) => BxMallSubDtoModel.fromJson(item)).toList()
    );
  }
}
