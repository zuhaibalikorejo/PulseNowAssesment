class ErrorInfo {
  String? code;
  String? desc;

  ErrorInfo({this.code, this.desc});

  ErrorInfo.fromJson(Map<String, dynamic> json) {
    if(json['code'] != null) {
      code = json['code'];
    }
    if(json['desc'] != null) {
      desc = json['desc'];
    }
    if(json['errorCode'] != null) {
      code = json['errorCode'];
    }
    if(json['errorDesc'] != null) {
      desc = json['errorDesc'];
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['desc'] = desc;
    return data;
  }
}