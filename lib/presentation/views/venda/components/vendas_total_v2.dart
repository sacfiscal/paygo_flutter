import 'package:flutter/material.dart';
import 'package:paygo_app/commons/style/application_colors.dart';

enum TipoVendaTotal {
  valorProdutos,
  valorfrete,
  valorSeguro,
  valorDesconto,
  valorOutros,
  valorTotal,
}

class VendasTotal extends StatelessWidget {
  final String label;
  final double valorTotal;
  final TipoVendaTotal tipo;

  const VendasTotal({
    Key? key,
    required this.label,
    required this.valorTotal,
    required this.tipo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'R\$ ${valorTotal.toStringAsFixed(2)}',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14,
                color: () {
                  switch (tipo) {
                    case TipoVendaTotal.valorProdutos:
                      return Color.fromARGB(255, 31, 123, 198);
                    case TipoVendaTotal.valorTotal:
                      return Color.fromARGB(255, 38, 105, 40);
                    case TipoVendaTotal.valorDesconto:
                      return Color.fromARGB(255, 185, 55, 46);
                    default:
                      return ApplicationColors.paygoDark;
                  }
                }(),
                fontWeight: () {
                  switch (tipo) {
                    case TipoVendaTotal.valorProdutos:
                      return FontWeight.w600;
                    case TipoVendaTotal.valorTotal:
                      return FontWeight.w600;
                    case TipoVendaTotal.valorDesconto:
                      return FontWeight.w600;
                    default:
                      return FontWeight.w400;
                  }
                }(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
