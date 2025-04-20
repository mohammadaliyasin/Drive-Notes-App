import 'dart:developer' as developer;

class Logger {
  static void log(String message, {String tag = 'LOG'}) {
    developer.log('[$tag]: $message');
  }
}
