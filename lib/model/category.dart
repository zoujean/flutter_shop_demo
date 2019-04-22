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
      data: json['data'],
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
      json.map((i)=>CategoryBigModel.fromJson((i))).toList()
    );
  }
  
}

