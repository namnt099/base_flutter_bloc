import 'datum.dart';

class DataWalletResponse {
  List<Datum>? data;
  int? statusCode;
  bool? success;
  String? message;

  DataWalletResponse({
    this.data,
    this.statusCode,
    this.success,
    this.message,
  });

  factory DataWalletResponse.fromJson(Map<String, dynamic> json) {
    return DataWalletResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
        'statusCode': statusCode,
        'success': success,
        'message': message,
      };
}
