import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartCard extends StatelessWidget {
  const LineChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: const Color(0xFF6366F1),
                  spots: [
                    FlSpot(0, 1),
                    FlSpot(1, 2),
                    FlSpot(2, 1.5),
                    FlSpot(3, 3),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
