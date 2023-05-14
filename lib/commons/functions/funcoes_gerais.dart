import 'package:flutter/material.dart';

void cancelFocus(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  currentFocus.unfocus();
}
