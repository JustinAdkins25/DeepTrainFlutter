// lib/app/components/footer_widget.dart

import 'package:flutter/material.dart';



class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black,
      child: Center(
        child: Text(
          'DeepTrain © 2025 | All rights reserved.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}