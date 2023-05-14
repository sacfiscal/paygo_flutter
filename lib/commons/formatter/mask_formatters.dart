import 'package:flutter/services.dart';

// formatar CEP no formato xxxxx-xxx
class CepFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.length > 5) {
      text = '${text.substring(0, 5)}-${text.substring(5, text.length)}';
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
  }
}

class CnpjCpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.length > 11) {
      text = _formatCNPJ(text);
    } else {
      text = _formatCPF(text);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
  }
}

class TelefoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.length > 10) {
      text = _formatTelefone11(text);
    } else {
      text = _formatTelefone10(text);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    String newText = "R\$ ${value.toStringAsFixed(2)}";

    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }
}

String formatarCep(String value) {
  if (value.isEmpty) return '';

  value = value.replaceAll(RegExp(r'[^\d]'), '');

  if (value.length > 5) {
    value = '${value.substring(0, 5)}-${value.substring(5, value.length)}';
  }

  return value;
}

String formatarCnpjCpf(String value) {
  if (value.isEmpty) return '';

  value = value.replaceAll(RegExp(r'[^\d]'), '');

  if (value.length > 11) {
    value = _formatCNPJ(value);
  } else {
    value = _formatCPF(value);
  }

  return value;
}

String _formatCPF(String value) {
  // formatar telefone no formato (xx) xxxx-xxxx
  if (value.isEmpty) return '';
  value = value.replaceAll(RegExp(r'[^\d]'), '');
  if (value.length > 3) {
    value = '${value.substring(0, 3)}.${value.substring(3, value.length)}';
  }
  if (value.length > 7) {
    value = '${value.substring(0, 7)}.${value.substring(7, value.length)}';
  }
  if (value.length > 11) {
    value = '${value.substring(0, 11)}-${value.substring(11, value.length)}';
  }
  return value;
}

String _formatCNPJ(String value) {
  // formatar telefone no formato (xx) xxxx-xxxx
  if (value.isEmpty) return '';
  value = value.replaceAll(RegExp(r'[^\d]'), '');
  if (value.length > 2) {
    value = '${value.substring(0, 2)}.${value.substring(2, value.length)}';
  }
  if (value.length > 6) {
    value = '${value.substring(0, 6)}.${value.substring(6, value.length)}';
  }
  if (value.length > 10) {
    value = '${value.substring(0, 10)}/${value.substring(10, value.length)}';
  }
  if (value.length > 15) {
    value = '${value.substring(0, 15)}-${value.substring(15, value.length)}';
  }

  return value;
}

String formatarTelefone(String value) {
  if (value.isEmpty) return '';

  value = value.replaceAll(RegExp(r'[^\d]'), '');

  if (value.length <= 10) {
    value = _formatTelefone10(value);
  } else {
    value = _formatTelefone11(value);
  }

  return value;
}

String _formatTelefone10(String value) {
  // formatar telefone no formato (xx) xxxx-xxxx
  if (value.isEmpty) return '';
  value = value.replaceAll(RegExp(r'[^\d]'), '');
  if (value.length > 2) {
    value = '(${value.substring(0, 2)}) ${value.substring(2, value.length)}';
  }
  if (value.length > 9) {
    value = '${value.substring(0, 9)}-${value.substring(9, value.length)}';
  }
  return value;
}

String _formatTelefone11(String value) {
  // formatar telefone no formato (xx) xxxxx-xxxx
  if (value.isEmpty) return '';
  value = value.replaceAll(RegExp(r'[^\d]'), '');
  if (value.length > 2) {
    value = '(${value.substring(0, 2)}) ${value.substring(2, value.length)}';
  }
  if (value.length > 10) {
    value = '${value.substring(0, 10)}-${value.substring(10, value.length)}';
  }
  return value;
}
