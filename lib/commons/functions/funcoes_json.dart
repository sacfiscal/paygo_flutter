import 'dart:convert';

String identarJson(Map<String, dynamic> jsonObject) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(jsonObject);
}
