import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../formatter/mask_formatters.dart';
import '../../style/application_colors.dart';

enum TipoCampo {
  padrao,
  cpfCnpj,
  cep,
  telefone,
  id,
  codigo,
  valor,
}

class TextFormFieldPadrao extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final TipoCampo? tipoCampo;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final int maxLines;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry contentPadding;
  final bool? obscureText;
  final Color? disableColor;
  final Color? alternativeColor;
  final bool? isDense;
  final double? fontSize;

  const TextFormFieldPadrao({
    Key? key,
    this.initialValue,
    this.hintText = '',
    this.labelText = '',
    this.tipoCampo = TipoCampo.padrao,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.contentPadding = const EdgeInsets.fromLTRB(0, 15, 0, 0),
    this.obscureText = false,
    this.disableColor,
    this.alternativeColor,
    this.isDense = false,
    this.fontSize = 11,
  }) : super(key: key);

  List<TextInputFormatter>? getFormatter(TipoCampo tipoCampo) {
    switch (tipoCampo) {
      case TipoCampo.cpfCnpj:
        return [
          LengthLimitingTextInputFormatter(18),
          FilteringTextInputFormatter.digitsOnly,
          CnpjCpfFormatter(),
        ];
      case TipoCampo.cep:
        return [
          LengthLimitingTextInputFormatter(9),
          FilteringTextInputFormatter.digitsOnly,
          CepFormatter(),
        ];
      case TipoCampo.telefone:
        return [
          LengthLimitingTextInputFormatter(15),
          FilteringTextInputFormatter.digitsOnly,
          TelefoneFormatter(),
        ];
      case TipoCampo.id:
        return [
          LengthLimitingTextInputFormatter(8),
          FilteringTextInputFormatter.digitsOnly,
        ];
      case TipoCampo.codigo:
        return [
          LengthLimitingTextInputFormatter(8),
          FilteringTextInputFormatter.digitsOnly,
        ];
      case TipoCampo.valor:
        return [
          CurrencyTextInputFormatter(
            locale: 'pt_BR',
            decimalDigits: 2,
            symbol: '',
          ),
        ];
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding,
      child: TextFormField(
        controller: TextEditingController(text: initialValue),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        readOnly: readOnly,
        enabled: enabled,
        autofocus: autofocus,
        maxLines: maxLines,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        style: enabled
            ? TextStyle(
                color: alternativeColor ?? ApplicationColors.paygoDark[900],
                fontSize: fontSize ?? 13,
              )
            : TextStyle(
                color: disableColor ?? ApplicationColors.paygoYellow[900],
                fontSize: fontSize ?? 13,
                fontWeight: FontWeight.w700,
              ),
        inputFormatters: getFormatter(tipoCampo!),
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon,
          isDense: isDense,
          labelStyle: enabled
              ? TextStyle(
                  color: alternativeColor ?? ApplicationColors.paygoDark[900],
                )
              : TextStyle(
                  color: disableColor ?? ApplicationColors.paygoYellow[900],
                ),
          errorStyle: TextStyle(
            color: ApplicationColors.paygoTomato[500],
            fontSize: fontSize,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: alternativeColor ?? ApplicationColors.paygoDark[900]!,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: alternativeColor ?? ApplicationColors.paygoDark[900]!,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: alternativeColor ?? ApplicationColors.paygoDark[900]!,
            ),
          ),
          disabledBorder: enabled
              ? null
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: enabled
                        ? alternativeColor ?? ApplicationColors.paygoDark[900]!
                        : disableColor ?? ApplicationColors.paygoYellow[900]!,
                  ),
                ),
        ),
      ),
    );
  }
}
