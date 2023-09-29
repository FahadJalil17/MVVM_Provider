

abstract class BaseApiServices{
  // 2 abstract methods

  Future<dynamic> getGetApiResponse(String url);  // Abstract method with one parameter

  // in body of post api you send data
  Future<dynamic> getPostApiResponse(String url, dynamic data);

}