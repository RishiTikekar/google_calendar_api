import 'package:flutter/material.dart';

class TimingHeader extends StatelessWidget {
  final String headerText;
  const TimingHeader({
    super.key,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 17,
            child: VerticalDivider(
              color: Colors.blue,
              thickness: 2,
              width: 2,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            headerText,
            // style: LTextStyles.title1(Clr.white),
          ),
        ],
      ),
    );
  }
}
