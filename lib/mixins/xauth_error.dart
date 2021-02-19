import 'package:graphql/client.dart';

mixin XAuthError {
  void checkForError(QueryResult queryResult, {String key, String errorKey}) {
    if (queryResult.hasException)
      throw XAuthException(queryResult.exception.toString());
    if (key != null && errorKey != null) {
      Map<String, Object> data = (queryResult?.data as LazyCacheMap)?.data;
      Map<String, Object> content = data[key];
      List errors = content[errorKey];
      if (errors.length != 0) {
        throw XAuthException(errors);
      }
    }
  }
}

class XAuthException implements Exception {
  final dynamic message;

  XAuthException([this.message]);

  String toString() {
    Object message = this.message;
    if (message == null) return "XAuthException";
    return "XAuthException: $message";
  }
}