import 'package:flutter/material.dart';

class StudentStats extends StatelessWidget {
  final String user;

  const StudentStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> studentStats = [
      {
        'title': 'Total Students',
        'value': '10,429',
        'change': '2.5%',
        'icon': Icons.people,
      },
      {
        'title': 'Total Projects Completed',
        'value': '30,212',
        'change': '0.5%',
        'icon': Icons.school,
      },
      {
        'title': 'Avg. Completion Rate',
        'value': '83%',
        'change': '-3%',
        'icon': Icons.grade,
      },
    ];

    return Expanded(
      flex: 2,
      child: Column(
        children: studentStats.map((item) {
          final double changeValue = double.tryParse(item['change'].replaceAll('%', '')) ?? 0.0;
          final bool isPositive = changeValue >= 0;
          final IconData changeIcon = isPositive ? Icons.trending_up : Icons.trending_down;
          final Color changeColor = isPositive ? Colors.green : Colors.red;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9F9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(item['icon'], size: 20, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      item['value'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Icon(changeIcon, color: changeColor, size: 24),
                        const SizedBox(width: 4),
                        Text(
                          item['change'],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: changeColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
