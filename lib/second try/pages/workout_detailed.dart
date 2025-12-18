// workout_detail_page.dart
import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatefulWidget {
  final Map<String, dynamic> plan;

  const WorkoutDetailPage({super.key, required this.plan});

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  // Dummy workout days for the selected plan
  final List<Map<String, dynamic>> workoutDays = [
    {
      'day': 1,
      'title': 'Chest & Triceps',
      'exercises': [
        {'name': 'Barbell Bench Press', 'sets': '4x8-12', 'rest': '90s'},
        {'name': 'Incline Dumbbell Press', 'sets': '3x10-12', 'rest': '90s'},
        {'name': 'Cable Flyes', 'sets': '3x12-15', 'rest': '60s'},
        {'name': 'Tricep Pushdowns', 'sets': '3x12-15', 'rest': '60s'},
        {'name': 'Overhead Tricep Extension', 'sets': '3x10-12', 'rest': '60s'},
      ],
      'duration': '60 mins',
      'completed': true,
    },
    {
      'day': 2,
      'title': 'Back & Biceps',
      'exercises': [
        {'name': 'Deadlifts', 'sets': '4x5-8', 'rest': '120s'},
        {'name': 'Pull-ups', 'sets': '3xMax', 'rest': '90s'},
        {'name': 'Bent Over Rows', 'sets': '4x8-12', 'rest': '90s'},
        {'name': 'Barbell Curls', 'sets': '3x10-12', 'rest': '60s'},
        {'name': 'Hammer Curls', 'sets': '3x12-15', 'rest': '60s'},
      ],
      'duration': '65 mins',
      'completed': true,
    },
    {
      'day': 3,
      'title': 'Leg Day',
      'exercises': [
        {'name': 'Squats', 'sets': '4x8-12', 'rest': '120s'},
        {'name': 'Leg Press', 'sets': '3x10-15', 'rest': '90s'},
        {'name': 'Romanian Deadlifts', 'sets': '3x10-12', 'rest': '90s'},
        {'name': 'Leg Extensions', 'sets': '3x12-15', 'rest': '60s'},
        {'name': 'Calf Raises', 'sets': '4x15-20', 'rest': '60s'},
      ],
      'duration': '75 mins',
      'completed': false,
    },
    {
      'day': 4,
      'title': 'Shoulders & Abs',
      'exercises': [
        {'name': 'Overhead Press', 'sets': '4x8-12', 'rest': '90s'},
        {'name': 'Lateral Raises', 'sets': '3x12-15', 'rest': '60s'},
        {'name': 'Front Raises', 'sets': '3x12-15', 'rest': '60s'},
        {'name': 'Plank', 'sets': '3x60s', 'rest': '45s'},
        {'name': 'Cable Crunches', 'sets': '3x15-20', 'rest': '45s'},
      ],
      'duration': '55 mins',
      'completed': false,
    },
    {
      'day': 5,
      'title': 'Full Body',
      'exercises': [
        {'name': 'Bench Press', 'sets': '3x8-10', 'rest': '90s'},
        {'name': 'Pull-ups', 'sets': '3xMax', 'rest': '90s'},
        {'name': 'Squats', 'sets': '3x8-10', 'rest': '90s'},
        {'name': 'Shoulder Press', 'sets': '3x10-12', 'rest': '60s'},
        {'name': 'Plank', 'sets': '3x45s', 'rest': '45s'},
      ],
      'duration': '60 mins',
      'completed': false,
    },
  ];

  int _selectedDay = 3; // Currently selected day (Leg Day)
  bool _isWorkoutStarted = false;
  int _currentExerciseIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedDay = workoutDays.firstWhere(
      (day) => day['day'] == _selectedDay,
      orElse: () => workoutDays[0],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plan['name']),
        actions: [IconButton(icon: Icon(Icons.share), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plan Overview
              Card(
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
                              color: widget.plan['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.plan['difficulty'],
                              style: TextStyle(
                                color: widget.plan['color'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.timer, size: 16),
                          SizedBox(width: 4),
                          Text(widget.plan['duration']),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        widget.plan['name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(widget.plan['description']),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          _buildPlanStat(
                            '${widget.plan['daysPerWeek']} days/week',
                            Icons.calendar_today,
                          ),
                          SizedBox(width: 16),
                          _buildPlanStat(
                            '${widget.plan['exercises']} exercises/day',
                            Icons.list,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Workout Schedule
              Text(
                'Workout Schedule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: workoutDays.length,
                  itemBuilder: (context, index) {
                    final day = workoutDays[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = day['day'];
                          _isWorkoutStarted = false;
                          _currentExerciseIndex = 0;
                        });
                      },
                      child: Container(
                        width: 70,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: _selectedDay == day['day']
                              ? Colors.blue[50]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedDay == day['day']
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Day ${day['day']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedDay == day['day']
                                    ? Colors.blue
                                    : Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 4),
                            day['completed']
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 16,
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                            SizedBox(height: 4),
                            Text(
                              day['duration'],
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              // Selected Day Details
              Row(
                children: [
                  Text(
                    selectedDay['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  if (selectedDay['completed'])
                    Chip(
                      label: Text('Completed'),
                      backgroundColor: Colors.green[50],
                      avatar: Icon(Icons.check, size: 16),
                    )
                  else
                    Chip(
                      label: Text('Pending'),
                      backgroundColor: Colors.orange[50],
                      avatar: Icon(Icons.access_time, size: 16),
                    ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Duration: ${selectedDay['duration']}',
                style: TextStyle(color: Colors.grey[600]),
              ),

              SizedBox(height: 20),

              // Exercises List
              if (_isWorkoutStarted)
                _buildActiveWorkoutView(selectedDay)
              else
                ...selectedDay['exercises'].map<Widget>((exercise) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 8),
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
                          Text('Rest: ${exercise['rest']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.play_circle_fill, color: Colors.blue),
                        onPressed: () {
                          _showExerciseInstructions(exercise['name']);
                        },
                      ),
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _isWorkoutStarted
          ? _buildActiveWorkoutControls(selectedDay)
          : _buildStartWorkoutButton(selectedDay),
    );
  }

  Widget _buildPlanStat(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget _buildActiveWorkoutView(Map<String, dynamic> selectedDay) {
    final exercises = selectedDay['exercises'];
    final currentExercise = exercises[_currentExerciseIndex];

    return Column(
      children: [
        // Current Exercise
        Card(
          color: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Current Exercise',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  currentExercise['name'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildExerciseStat('Sets', currentExercise['sets']),
                    _buildExerciseStat('Rest', currentExercise['rest']),
                    _buildExerciseStat(
                      'Progress',
                      '${_currentExerciseIndex + 1}/${exercises.length}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),

        // Exercise Sets Tracker
        Text(
          'Track Your Sets',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        ...List.generate(4, (setIndex) {
          return Card(
            margin: EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    'Set ${setIndex + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Reps',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Checkbox(
                    value: setIndex < 2, // Dummy completed sets
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          );
        }),

        SizedBox(height: 20),

        // Upcoming Exercises
        Text(
          'Upcoming Exercises',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        ...exercises.asMap().entries.map((entry) {
          final index = entry.key;
          final exercise = entry.value;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: index == _currentExerciseIndex
                  ? Colors.blue
                  : Colors.grey[200],
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: index == _currentExerciseIndex
                      ? Colors.white
                      : Colors.grey[700],
                ),
              ),
            ),
            title: Text(exercise['name']),
            subtitle: Text('${exercise['sets']} • Rest: ${exercise['rest']}'),
            trailing: index == _currentExerciseIndex
                ? Icon(Icons.play_arrow, color: Colors.blue)
                : null,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildExerciseStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildStartWorkoutButton(Map<String, dynamic> selectedDay) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: selectedDay['completed']
          ? ElevatedButton.icon(
              onPressed: () {
                // Repeat workout
                _startWorkout();
              },
              icon: Icon(Icons.replay),
              label: Text('Repeat This Workout'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            )
          : ElevatedButton.icon(
              onPressed: () {
                _startWorkout();
              },
              icon: Icon(Icons.play_arrow),
              label: Text('Start Workout'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
    );
  }

  Widget _buildActiveWorkoutControls(Map<String, dynamic> selectedDay) {
    final exercises = selectedDay['exercises'];

    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          if (_currentExerciseIndex > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentExerciseIndex--;
                  });
                },
                icon: Icon(Icons.skip_previous),
                label: Text('Previous'),
              ),
            ),
          if (_currentExerciseIndex > 0) SizedBox(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                if (_currentExerciseIndex < exercises.length - 1) {
                  setState(() {
                    _currentExerciseIndex++;
                  });
                } else {
                  _completeWorkout(selectedDay);
                }
              },
              icon: _currentExerciseIndex < exercises.length - 1
                  ? Icon(Icons.skip_next)
                  : Icon(Icons.done_all),
              label: Text(
                _currentExerciseIndex < exercises.length - 1
                    ? 'Next Exercise'
                    : 'Complete Workout',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentExerciseIndex < exercises.length - 1
                    ? Colors.blue
                    : Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startWorkout() {
    setState(() {
      _isWorkoutStarted = true;
      _currentExerciseIndex = 0;
    });
  }

  void _completeWorkout(Map<String, dynamic> selectedDay) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Workout Completed! 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 60, color: Colors.green),
            SizedBox(height: 16),
            Text('Great job completing ${selectedDay['title']}!'),
            SizedBox(height: 8),
            Text(
              'Duration: ${selectedDay['duration']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isWorkoutStarted = false;
                selectedDay['completed'] = true;
              });
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showExerciseInstructions(String exerciseName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$exerciseName Instructions'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
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
                'Proper Form Tips:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('• Tip ${index + 1} for $exerciseName'),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Common Mistakes:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),
              ...List.generate(
                2,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('• Avoid this mistake ${index + 1}'),
                ),
              ),
            ],
          ),
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
