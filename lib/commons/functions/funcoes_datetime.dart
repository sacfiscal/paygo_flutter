import 'package:intl/intl.dart';

String converterDateTimeStrBr(DateTime valor) {
  return DateFormat('dd/MM/yyyy HH:mm:ss').format(valor);
}

DateTime converterStrBrDateTime(String valor) {
  return DateFormat('dd/MM/yyyy HH:mm:ss').parse(valor);
}

String converterDateTimeIso(DateTime valor) {
  return valor.toIso8601String();
}

DateTime converterIsoDateTime(String valor) {
  return DateTime.parse(valor);
}

String isoToBrDateTimeString(String? isoDateString) {
  try {
    DateTime dateTime = DateTime.parse(isoDateString!).toLocal();
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
  } catch (e) {
    return '';
  }
}

String brDateTimeStringToIso(String brDateTimeString) {
  DateTime dateTime = DateFormat('dd/MM/yyyy HH:mm:ss').parse(brDateTimeString);
  return dateTime.toUtc().toIso8601String();
}

String dateToNFe(DateTime dateTime) {
  String formattedDateTime = dateTime.toUtc().toIso8601String();
  formattedDateTime = '${formattedDateTime.substring(0, 23)}Z';
  return formattedDateTime;
}
