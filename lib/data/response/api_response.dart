
import 'package:mvvm_provider/data/response/status.dart';

class ApiResponse<T>{
  Status? status;  // Status is coming from enum class
  T? data;  // dynamic
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADINNG;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  // if error occurs it will go to AppException class
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString(){
    return "Status : $status \n Message : $message \n Data : $data";
  }

}
