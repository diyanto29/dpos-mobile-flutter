class ResponseMessage{
  final String message;
  final bool status;
  final dynamic data;

  ResponseMessage( {required this.message, required this.status,this.data});
}