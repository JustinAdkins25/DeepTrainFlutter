import 'package:flutter/material.dart';

class ScenariosList extends StatelessWidget {
  const ScenariosList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Scenarios", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ListTile(
              leading: Icon(Icons.play_arrow),
              title: Text("Scenario 1"),
              subtitle: Text("Last run: 2 days ago"),
            ),
            ListTile(
              leading: Icon(Icons.play_arrow),
              title: Text("Scenario 2"),
              subtitle: Text("Last run: 5 days ago"),
            ),
          ],
        ),
      ),
    );
  }
}
