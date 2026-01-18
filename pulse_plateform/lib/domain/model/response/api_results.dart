

import 'package:pulse_plateform/domain/model/response/error_info.dart';

class ApiResults {
  String? status;
  ErrorInfo? errorInfo;

  ApiResults({this.status, this.errorInfo});

  ApiResults.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorInfo = json['errorInfo'] != null ? ErrorInfo.fromJson(json['errorInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (errorInfo != null) {
      data['errorInfo'] = errorInfo!.toJson();
    }
    return data;
  }

  bool isSuccess() {
    return 'success' == status;
  }
}
