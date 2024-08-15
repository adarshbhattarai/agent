class ApiResponse<T>{

  late T data;
  late bool error;
  late String errorMessage;

  ApiResponse({
    required this.data,
    this.error = false,
    this.errorMessage = '',
  });

}