import 'package:flutter/material.dart';

class TestimonialSection extends StatelessWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9FAFB),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Testimonials', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(2, (index) => TestimonialCard(index: index)),
          ),
        ],
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final int index;
  const TestimonialCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('"DeepTrain changed how we train our team!"', style: TextStyle(fontStyle: FontStyle.italic)),
              SizedBox(height: 8),
              Text('- User ${1}', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
