import 'package:flutter/material.dart';
import '../models/node_block.dart';

class ConnectionPainter extends CustomPainter {
  final List<NodeBlock> blocks;

  ConnectionPainter(this.blocks);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black45
      ..strokeWidth = 2;

    for (int i = 0; i < blocks.length - 1; i++) {
      final from = blocks[i].offset + const Offset(50, 20);
      final to = blocks[i + 1].offset + const Offset(50, 20);
      canvas.drawLine(from, to, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConnectionPainter oldDelegate) => true;
}
