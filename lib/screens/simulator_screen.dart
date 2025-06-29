import 'package:flutter/material.dart';

class SimulatorScreen extends StatelessWidget {
  const SimulatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulator')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Simulation Status: ACTIVE', style: TextStyle(fontSize: 20)),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Incoming Event:', style: TextStyle(fontSize: 16)),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Load Simulation'),
                onPressed: () {
                  // hook up loading logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Load Simulation button')),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Trainee response',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onSubmitted: (value) {
                //  Send to LLM Gateway
              },
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text('Submit Response'),
            onPressed: () {
              //  Call API to submit response
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
