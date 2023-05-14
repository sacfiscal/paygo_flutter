import 'package:flutter/material.dart';

class VendasTotal extends StatelessWidget {
  final String label;
  final double valorTotal;

  const VendasTotal({
    Key? key,
    required this.label,
    required this.valorTotal,
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
                color: Colors.white,
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
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
