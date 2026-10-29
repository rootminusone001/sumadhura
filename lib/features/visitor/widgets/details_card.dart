import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final List<Widget> cardChildren;
  const DetailsCard({super.key, required this.cardChildren});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (int i = 0; i < cardChildren.length; i++) ...[
              cardChildren[i],
              if (i != cardChildren.length - 1) const Divider(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}
