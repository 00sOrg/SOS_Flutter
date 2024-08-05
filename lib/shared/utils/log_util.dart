import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    // methodCount: 2,
    // errorMethodCount: 8,
    // lineLength: 80,
    colors: true,
    printEmojis: true,
    // printTime: false,
  ),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class LogUtil {
  static void d(String message) {
    logger.d(message);
  }

  static void e(String message
  // , [dynamic error, StackTrace? stackTrace]
  ) {
    logger.e(message);
  }

  static void i(String message) {
    logger.i(message);
  }

  static void w(String message) {
    logger.w(message);
  }

  static void v(String message) {
    logger.v(message);
  }

  static void logNoStack(String message) {
    loggerNoStack.d(message);
  }
}