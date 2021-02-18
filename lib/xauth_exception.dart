part of flutter_xauth_sdk;

class XAuthExeption implements Exception {
  final String name;
  final String description;
  XAuthExeption(
      {this.name = 'a0.response.invalid', this.description = 'unknown error'});
}