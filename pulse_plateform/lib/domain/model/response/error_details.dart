class ErrorDetails {
  String? code;
  String? message;
  dynamic response;

  ErrorDetails({this.code, this.message, this.response});

  ErrorDetails.fromJson(Map<String, dynamic> json) {
    code = json['errorInfo']['code'];
    message = json['errorInfo']['desc'];
    response = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['desc'] = message;
    data['response'] = response;
    return data;
  }
}