enum Status{LOADING,COMPLETED,ERROR}

class ApiResponse<T>{
  final Status status;
  final T data;
  final String message;

  ApiResponse({required this.status, required this.data, required this.message});

  ApiResponse.loading({required this.data, required this.message}) : status = Status.LOADING;
  ApiResponse.completed({required this.data, required this.message}) : status = Status.COMPLETED;
  ApiResponse.error({required this.data, required this.message}) : status = Status.ERROR;

  @override
  String toString(){
    return 'Status : $status \n message : $message \n data : $data';
  }
}