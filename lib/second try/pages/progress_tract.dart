// progress_page.dart
import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  // Dummy progress data
  final List<Map<String, dynamic>> weightHistory = [
    {'date': 'Jan 1', 'weight': 85.5, 'bodyFat': 22.5},
    {'date': 'Jan 8', 'weight': 84.8, 'bodyFat': 22.0},
    {'date': 'Jan 15', 'weight': 84.2, 'bodyFat': 21.5},
    {'date': 'Jan 22', 'weight': 83.7, 'bodyFat': 21.0},
    {'date': 'Jan 29', 'weight': 83.0, 'bodyFat': 20.5},
    {'date': 'Feb 5', 'weight': 82.5, 'bodyFat': 20.0},
    {'date': 'Feb 12', 'weight': 82.0, 'bodyFat': 19.5},
  ];

  final Map<String, dynamic> personalRecords = {
    'Bench Press': {'current': 85, 'goal': 100, 'unit': 'kg'},
    'Squat': {'current': 120, 'goal': 140, 'unit': 'kg'},
    'Deadlift': {'current': 140, 'goal': 160, 'unit': 'kg'},
    'Pull-ups': {'current': 8, 'goal': 15, 'unit': 'reps'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracking'),
        actions: [IconButton(icon: Icon(Icons.add_chart), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weight Progress Chart
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: weightHistory.asMap().entries.map((entry) {
                          final data = entry.value;
                          final maxWeight = 90.0;
                          final minWeight = 80.0;
                          final weightPercentage =
                              (data['weight'] - minWeight) /
                              (maxWeight - minWeight);

                          return Container(
                            width: 60,
                            margin: EdgeInsets.only(right: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(data['date']),
                                SizedBox(height: 4),
                                Container(
                                  height: weightPercentage * 150,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text('${data['weight']}kg'),
                                SizedBox(height: 2),
                                Text(
                                  '${data['bodyFat']}%',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Personal Records
            Text(
              'Personal Records',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ...personalRecords.entries.map((entry) {
              final exercise = entry.key;
              final data = entry.value;
              final progress = data['current'] / data['goal'];

              return Card(
                margin: EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        color: progress >= 1 ? Colors.green : Colors.blue,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${data['current']} ${data['unit']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Goal: ${data['goal']} ${data['unit']}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 20),

            // Progress Photos (Placeholder)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress Photos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPhotoCard('Start', 'assets/start.jpg'),
                        _buildPhotoCard('Current', 'assets/current.jpg'),
                        _buildPhotoCard('Goal', 'assets/goal.jpg'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoCard(String title, String imagePath) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Icon(Icons.camera_alt, color: Colors.grey[400]),
        ),
        SizedBox(height: 4),
        Text(title),
      ],
    );
  }
}
