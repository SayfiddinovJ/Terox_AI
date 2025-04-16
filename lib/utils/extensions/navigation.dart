import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> push<T>(Widget page) {
    return Navigator.of(
      this,
    ).push<T>(MaterialPageRoute(builder: (context) => page));
  }

  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.of(
      this,
    ).pushReplacement<T, TO>(MaterialPageRoute(builder: (context) => page));
  }

  Future<T?> pushAndRemoveUntil<T>(
      Widget page, {
        bool Function(Route<dynamic>)? predicate,
      }) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (context) => page),
      predicate ?? (route) => false,
    );
  }

  void pop<T extends Object?>([T? result]) {
    if (canPop()) {
      Navigator.of(this).pop(result);
    }
  }

  bool canPop() => Navigator.of(this).canPop();
}
