import 'package:flutter/material.dart';

import '../../style/application_colors.dart';

class DividerPadrao extends StatelessWidget {
  final String label;

  const DividerPadrao({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ApplicationColors.paygoDark[900]!.withAlpha(140),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Divider(
              color: ApplicationColors.paygoDark[900]!.withAlpha(90),
              height: 6,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
