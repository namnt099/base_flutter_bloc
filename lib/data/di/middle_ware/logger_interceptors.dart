import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class CustomLogger extends PrettyDioLogger {
  CustomLogger()
      : super(
          requestHeader: true,
          requestBody: true,
          maxWidth: 100,
        );
}
