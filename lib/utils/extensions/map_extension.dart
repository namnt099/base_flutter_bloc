
import '../../data/exception/remote_exception.dart';

extension MapParse on Map<dynamic, dynamic> {
  String? stringValueOrNull(String key) {
    final vl = this[key];
    if (vl != null && vl is String) {
      return vl;
    }
    return null;
  }

  String stringValueOrEmpty(String key) {
    final vl = this[key];
    if (vl != null && vl is String) {
      return vl;
    }
    return '';
  }

  bool boolValue(String key) {
    final vl = this[key];
    if (vl != null && vl is bool) {
      return vl;
    }
    return false;
  }

  int intValue(String key) {
    final vl = this[key];
    if (vl != null && vl is int) {
      return vl;
    }
    return 0;
  }

  double doubleValue(String key) {
    final vl = this[key];
    if (vl != null && vl is double) {
      return vl;
    }
    return 0.0;
  }

  dynamic dynamicValue(String key) {
    final vl = this[key];
    if (vl != null) {
      return vl;
    }
    return 0.0;
  }

  List<dynamic> arrayValueOrEmpty(String key) {
    final vl = this[key];
    if (vl != null && vl is List) {
      return vl;
    }
    return [];
  }

  Map<String, dynamic> mapValueOrEmpty(String key) {
    final vl = this[key];
    if (vl != null && vl is Map) {
      return vl as Map<String, dynamic>;
    }
    return {};
  }

  String compareWithZero(String key) {
    final int value = intValue(key);
    if (value == 0) {
      return '';
    }
    return value.toString();
  }

  RemoteExceptionKind remoteExceptionKind(String key) {
    final value = this[key];
    if (value != null && value is RemoteExceptionKind) {
      return value;
    }
    return RemoteExceptionKind.unknown;
  }
}

Map<String, dynamic> castToStringKey(Map<Object?, Object?> json) {
  final Map<String, dynamic> temp = {};
  json.forEach((key, value) {
    if (key is String) {
      temp[key] = value;
    }
  });
  return temp;
}
