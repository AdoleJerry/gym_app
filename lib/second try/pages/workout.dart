// workout_plan_page.dart
import 'package:flutter/material.dart';
import 'package:gym_app/second%20try/pages/workout_detailed.dart';

class WorkoutPlanPage extends StatefulWidget {
  const WorkoutPlanPage({super.key});

  @override
  _WorkoutPlanPageState createState() => _WorkoutPlanPageState();
}

class _WorkoutPlanPageState extends State<WorkoutPlanPage> {
  // Dummy workout plans
  final List<Map<String, dynamic>> workoutPlans = [
    {
      'name': 'Beginner Full Body',
      'difficulty': 'Beginner',
      'duration': '8 weeks',
      'daysPerWeek': 3,
      'exercises': 6,
      'description': 'Perfect for those starting their fitness journey',
      'color': Colors.green,
    },
    {
      'name': 'Muscle Building',
      'difficulty': 'Intermediate',
      'duration': '12 weeks',
      'daysPerWeek': 5,
      'exercises': 8,
      'description': 'Focus on hypertrophy and strength gains',
      'color': Colors.blue,
    },
    {
      'name': 'Strength & Power',
      'difficulty': 'Advanced',
      'duration': '10 weeks',
      'daysPerWeek': 4,
      'exercises': 7,
      'description': 'Maximize strength with compound movements',
      'color': Colors.orange,
    },
    {
      'name': 'Fat Loss Circuit',
      'difficulty': 'All Levels',
      'duration': '6 weeks',
      'daysPerWeek': 4,
      'exercises': 10,
      'description': 'High-intensity workouts for maximum calorie burn',
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Plans'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: workoutPlans.length,
        itemBuilder: (context, index) {
          final plan = workoutPlans[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: plan['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          plan['difficulty'],
                          style: TextStyle(
                            color: plan['color'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.timer, size: 16),
                      SizedBox(width: 4),
                      Text(plan['duration']),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    plan['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  Text(
                    plan['description'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      _buildPlanDetail(
                        '${plan['daysPerWeek']}/week',
                        Icons.calendar_today,
                      ),
                      SizedBox(width: 16),
                      _buildPlanDetail(
                        '${plan['exercises']} exercises',
                        Icons.list,
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WorkoutDetailPage(plan: plan),
                            ),
                          );
                        },
                        child: Text('Start Plan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create custom workout
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPlanDetail(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
