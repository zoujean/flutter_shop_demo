<<<<<<< HEAD
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future httpRequest(url, {formData}) async {
  try {
    print('开始获取数据...${formData.toString()}');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    if(formData == null){
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url],data: formData);
    }
    if(response.statusCode == 200) {
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况...');
    }
  } catch(e) {
    print(e);
  }
}

Future getHomePageContent(formData) async {
  // try {
  //   print('开始获取首页数据...');
  //   Response response;
  //   Dio dio = new Dio();
  //   dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
  //   var formData = {'lon':'115.02932','lat':'35.76189'};
  //   response = await dio.post(servicePath['homePageContext'],data: formData);
  //   if(response.statusCode == 200) {
  //     return response.data;
  //   }else{
  //     throw Exception('后端接口出现异常，请检测代码和服务器情况...');
  //   }
  // } catch(e) {
  //   print(e);
  // }
  // var formData = {'lon':'115.02932','lat':'35.76189'};
  return httpRequest('homePageContext', formData: formData);
}

Future getHomePageBeloConten(formData) async {
  // try {
  //   print('开始获取下拉列表数据...');
  //   Response response;
  //   Dio dio = new Dio();
  //   dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
  //   int page=1;
  //   response = await dio.post(servicePath['homePageBelowConten'],data:page);
  //   if(response.statusCode==200){
  //     return response.data;
  //   }else{
  //     throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
  //   }
  // } catch (e) {
  //   print(e);
  // }
  // int formData{'page': 1};
  return httpRequest('homePageBelowConten', formData: formData);
=======
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future httpRequest(url, {formData}) async {
  try {
    print('开始获取数据...${formData.toString()}');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    if(formData == null){
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url],data: formData);
    }
    if(response.statusCode == 200) {
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况...');
    }
  } catch(e) {
    print(e);
  }
}

Future getHomePageContent(formData) async {
  // try {
  //   print('开始获取首页数据...');
  //   Response response;
  //   Dio dio = new Dio();
  //   dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
  //   var formData = {'lon':'115.02932','lat':'35.76189'};
  //   response = await dio.post(servicePath['homePageContext'],data: formData);
  //   if(response.statusCode == 200) {
  //     return response.data;
  //   }else{
  //     throw Exception('后端接口出现异常，请检测代码和服务器情况...');
  //   }
  // } catch(e) {
  //   print(e);
  // }
  // var formData = {'lon':'115.02932','lat':'35.76189'};
  return httpRequest('homePageContext', formData: formData);
}

Future getHomePageBeloConten(formData) async {
  // try {
  //   print('开始获取下拉列表数据...');
  //   Response response;
  //   Dio dio = new Dio();
  //   dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
  //   int page=1;
  //   response = await dio.post(servicePath['homePageBelowConten'],data:page);
  //   if(response.statusCode==200){
  //     return response.data;
  //   }else{
  //     throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
  //   }
  // } catch (e) {
  //   print(e);
  // }
  // int formData{'page': 1};
  return httpRequest('homePageBelowConten', formData: formData);
>>>>>>> 62bb57bdf8bf51412607b42cd4bea3b43d0af46c
}