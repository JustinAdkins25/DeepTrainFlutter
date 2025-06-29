import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../state/scenario_provider.dart';
import '../shared/models/node_block.dart';

class ScenarioBuilderScreen extends ConsumerStatefulWidget {
  final String initialDomain;
  const ScenarioBuilderScreen({super.key, required this.initialDomain});

  @override
  ConsumerState<ScenarioBuilderScreen> createState() => _ScenarioBuilderScreenState();
}

class _ScenarioBuilderScreenState extends ConsumerState<ScenarioBuilderScreen> {
  late String selectedDomain;

  final List<String> nodeTypes = [
    'Start', 'Lesson', 'Quiz', 'Decision', 'Checkpoint', 'End', 'Interactive'
  ];

  final List<String> domains = [
    'Oil & Gas', 'IT Project Management', 'Healthcare', 'Military', 'Government', 'Finance'
  ];

  @override
  void initState() {
    super.initState();
    selectedDomain = widget.initialDomain;
  }

  void _addNode(String type, Offset offset) {
    ref.read(scenarioProvider.notifier).addNode(
      NodeBlock(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        offset: offset,
        type: type,
        title: type,
      ),
    );
  }

  void _editNode(NodeBlock block) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit ${block.type}'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width >= 800 ? 768 : null,
          height: MediaQuery.of(context).size.width >= 800 ? 512 : null,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: block.title,
                  onChanged: (val) => ref.read(scenarioProvider.notifier)
                      .updateNode(block.copyWith(title: val)),
                  decoration: const InputDecoration(labelText: 'Node Title'),
                ),
                const SizedBox(height: 8),

                if (block.type == 'Start') ...[
                  TextFormField(
                    initialValue: block.welcomeMessage ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(welcomeMessage: val)),
                    decoration: const InputDecoration(labelText: 'Welcome Message'),
                  ),
                ],

                if (block.type == 'Lesson') ...[
                  DropdownButtonFormField<String>(
                    value: block.lessonType ?? 'Text',
                    items: ['Text', 'Image', 'Video']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(lessonType: val)),
                    decoration: const InputDecoration(labelText: 'Lesson Type'),
                  ),
                  TextFormField(
                    initialValue: block.lessonContent ?? '',
                    maxLines: 10,
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(lessonContent: val)),
                    decoration: const InputDecoration(labelText: 'Lesson Content'),
                  ),
                  TextFormField(
                    initialValue: block.estimatedTime ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(estimatedTime: val)),
                    decoration: const InputDecoration(labelText: 'Estimated Time (minutes)'),
                    keyboardType: TextInputType.number,
                  ),
                ],

                if (block.type == 'Quiz') ...[
                  TextFormField(
                    initialValue: block.quizTitle ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(quizTitle: val)),
                    decoration: const InputDecoration(labelText: 'Quiz Title'),
                  ),
                  TextFormField(
                    initialValue: block.passingScore ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(passingScore: val)),
                    decoration: const InputDecoration(labelText: 'Passing Score (%)'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    initialValue: block.timeLimit ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(timeLimit: val)),
                    decoration: const InputDecoration(labelText: 'Time Limit (minutes)'),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // future: add quiz question
                    },
                    child: const Text('Add Question'),
                  ),
                ],

                if (block.type == 'Decision') ...[
                  TextFormField(
                    initialValue: block.conditionExpression ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(conditionExpression: val)),
                    decoration: const InputDecoration(labelText: 'Condition Expression'),
                  ),
                  TextFormField(
                    initialValue: block.truePathLabel ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(truePathLabel: val)),
                    decoration: const InputDecoration(labelText: 'True Path Label'),
                  ),
                  TextFormField(
                    initialValue: block.falsePathLabel ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(falsePathLabel: val)),
                    decoration: const InputDecoration(labelText: 'False Path Label'),
                  ),
                ],

                if (block.type == 'Checkpoint') ...[
                  TextFormField(
                    initialValue: block.checkpointTitle ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(checkpointTitle: val)),
                    decoration: const InputDecoration(labelText: 'Checkpoint Title'),
                  ),
                  TextFormField(
                    initialValue: block.checkpointNote ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(checkpointNote: val)),
                    decoration: const InputDecoration(labelText: 'Checkpoint Note'),
                  ),
                  TextFormField(
                    initialValue: block.estimatedTime ?? '',
                    onChanged: (val) => ref.read(scenarioProvider.notifier)
                        .updateNode(block.copyWith(estimatedTime: val)),
                    decoration: const InputDecoration(labelText: 'Estimated Time (minutes)'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Done')),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, bool isMobile) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.indigo),
            child: Text(
              'Scenario Designer',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
              value: selectedDomain,
              isExpanded: true,
              items: domains.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
              onChanged: (value) {
                if (value != null) setState(() => selectedDomain = value);
              },
            ),
          ),
          ExpansionTile(
            title: const Text('Node Palette'),
            children: nodeTypes.map((type) {
              return isMobile
                  ? ListTile(
                      leading: const Icon(Icons.touch_app),
                      title: Text(type),
                      onTap: () {
                        _addNode(type, const Offset(100, 100));
                        Navigator.pop(context);
                      },
                    )
                  : Draggable<String>(
                      data: type,
                      feedback: Material(
                        color: Colors.transparent,
                        child: Chip(label: Text(type)),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.drag_indicator),
                        title: Text(type),
                      ),
                    );
            }).toList(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Properties Inspector'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Properties Inspector coming soon')),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scenario = ref.read(scenarioProvider.notifier);
    final blocks = ref.watch(scenarioProvider);
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isMobile, // hamburger appears on mobile
        leading: isMobile
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/dashboard'),
              ),
        title: Text('Scenario Designer - $selectedDomain'),
        actions: [
          IconButton(icon: const Icon(Icons.undo), onPressed: scenario.undo),
          IconButton(icon: const Icon(Icons.redo), onPressed: scenario.redo),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New Scenario',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add scenario not implemented')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Save feature not implemented')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            tooltip: 'Load Scenario',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Load feature not implemented')),
              );
            },
          ),
        ],
      ),
      drawer: isMobile ? _buildSidebar(context, isMobile) : null,
      body: Row(
        children: [
          if (!isMobile) SizedBox(width: 260, child: _buildSidebar(context, isMobile)),
          Expanded(
            child: DragTarget<String>(
              onAcceptWithDetails: (details) {
                final renderBox = context.findRenderObject() as RenderBox;
                final offset = renderBox.globalToLocal(details.offset);
                _addNode(details.data, offset);
              },
              builder: (context, candidate, rejected) {
                return Stack(
                  children: [
                    CustomPaint(
                      painter: _ConnectionPainter(blocks),
                      child: Container(),
                    ),
                    ...blocks.map((block) => Positioned(
                          left: block.offset.dx,
                          top: block.offset.dy,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              scenario.moveNode(block, block.offset + details.delta);
                            },
                            onTap: () => _editNode(block),
                            child: Card(
                              color: Colors.indigo,
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(block.type,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    Text(block.title,
                                        style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectionPainter extends CustomPainter {
  final List<NodeBlock> blocks;
  _ConnectionPainter(this.blocks);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black38
      ..strokeWidth = 2;
    for (int i = 0; i < blocks.length - 1; i++) {
      final from = blocks[i].offset + const Offset(50, 20);
      final to = blocks[i + 1].offset + const Offset(50, 20);
      canvas.drawLine(from, to, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConnectionPainter oldDelegate) => true;
}
