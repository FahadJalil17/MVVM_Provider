
class AppException implements Exception{  // it implements exception class
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString(){
    return '$_prefix $_message';
  }
}

// All the possible exceptions which can occur in our case

// there is timeout for network request => if response is not get in 10 seconds => You have to timeout that request
// What type of exception it can be let's check that
class FetchDataException extends AppException{
  FetchDataException([String? message]) : super (message, "Error During Communication"); //The message we are returning to AppException
}

// it is a url/ which doesn't exist on that server
class BadRequestException extends AppException{
  BadRequestException([String? message]) : super(message, "Invalid Request");
}

// Every user has a token which shows he is authorized user and can acced that data
class UnauthorisedException extends AppException{
  UnauthorisedException([String? message]) : super(message, "Unauthorized Request");
}

class InvalidInputException extends AppException{
  InvalidInputException([String? message]) : super(message, "Invalid Input");
}

