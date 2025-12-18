// exercises_page.dart
import 'package:flutter/material.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final List<String> muscleGroups = [
    'Chest',
    'Back',
    'Legs',
    'Shoulders',
    'Biceps',
    'Triceps',
    'Abs',
    'Cardio',
  ];

  // Dummy exercises data
  final Map<String, List<Map<String, dynamic>>> exercisesByMuscleGroup = {
    'Chest': [
      {'name': 'Barbell Bench Press', 'sets': '4x8-12', 'equipment': 'Barbell'},
      {
        'name': 'Incline Dumbbell Press',
        'sets': '3x10-12',
        'equipment': 'Dumbbells',
      },
      {'name': 'Cable Flyes', 'sets': '3x12-15', 'equipment': 'Cable Machine'},
    ],
    'Back': [
      {'name': 'Deadlifts', 'sets': '4x5-8', 'equipment': 'Barbell'},
      {'name': 'Pull-ups', 'sets': '3xMax', 'equipment': 'Pull-up Bar'},
      {'name': 'Bent Over Rows', 'sets': '4x8-12', 'equipment': 'Barbell'},
    ],
    'Legs': [
      {'name': 'Squats', 'sets': '4x8-12', 'equipment': 'Barbell'},
      {
        'name': 'Leg Press',
        'sets': '3x10-15',
        'equipment': 'Leg Press Machine',
      },
      {'name': 'Lunges', 'sets': '3x12 each leg', 'equipment': 'Dumbbells'},
    ],
    'Shoulders': [
      {'name': 'Overhead Press', 'sets': '4x8-12', 'equipment': 'Barbell'},
      {'name': 'Lateral Raises', 'sets': '3x12-15', 'equipment': 'Dumbbells'},
      {'name': 'Face Pulls', 'sets': '3x15-20', 'equipment': 'Cable Machine'},
    ],
  };

  String selectedMuscleGroup = 'Chest';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: muscleGroups.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Exercises'),
          bottom: TabBar(
            isScrollable: true,
            tabs: muscleGroups.map((group) => Tab(text: group)).toList(),
          ),
        ),
        body: TabBarView(
          children: muscleGroups.map((group) {
            final exercises = exercisesByMuscleGroup[group] ?? [];
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      child: Icon(Icons.fitness_center, color: Colors.blue),
                    ),
                    title: Text(
                      exercise['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('Sets: ${exercise['sets']}'),
                        Text('Equipment: ${exercise['equipment']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.play_circle_fill, color: Colors.blue),
                      onPressed: () {
                        _showExerciseDemo(exercise['name']);
                      },
                    ),
                    onTap: () {
                      // Navigate to exercise detail
                    },
                  ),
                );
              },
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add custom exercise
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showExerciseDemo(String exerciseName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$exerciseName Demo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              color: Colors.grey[200],
              child: Center(
                child: Icon(
                  Icons.play_circle_filled,
                  size: 60,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Watch proper form and technique for $exerciseName',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
