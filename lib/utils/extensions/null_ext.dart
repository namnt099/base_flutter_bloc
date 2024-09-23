class ScanNull<T> {
  ScanNull._();
  static T getInstance<T>(dynamic data) {
    if (data == null) {
      throw Exception();
    }

    return data as T;
  }
}
