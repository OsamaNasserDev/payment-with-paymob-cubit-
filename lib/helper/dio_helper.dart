import 'package:dio/dio.dart';


class DioHelper{

  static Dio? dio ;

  static String baseUrl = 'https://accept.paymob.com/api/';
  // this function call in main
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Accept': 'application/json',
        }
      )
    );


  }

  static Future<Response> getData({endPoint , parameter , lang ='en' , token,ContentType}) async {
    dio!.options.headers=  {
      // 'lang' : lang ,
      // 'Content-Type':"application/json",
      'Authorization' : token ,
    };
    return await dio!.get(endPoint ,queryParameters: parameter);
  }

  // post data
  static Future<Response> postData({endPoint , data }) async {

      return await dio!.post(endPoint, data: data);

  }

  //
  // // Resister
  // // for post includes images
  // static Future<Response> postFormData({endPoint , formData}) async {
  //   return await dio!.post(endPoint,data: formData);
  // }

}
