// dashboard_page.dart
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  // Dummy data for stats
  final Map<String, dynamic> stats = {
    'workoutStreak': 7,
    'weeklyWorkouts': 4,
    'caloriesBurned': 2450,
    'workoutTime': '6h 30m',
  };

  final List<Map<String, dynamic>> upcomingWorkouts = [
    {
      'name': 'Chest & Triceps',
      'time': 'Today, 6:00 PM',
      'duration': '60 mins',
    },
    {'name': 'Leg Day', 'time': 'Tomorrow, 7:00 AM', 'duration': '75 mins'},
    {
      'name': 'Back & Biceps',
      'time': 'Wednesday, 6:30 PM',
      'duration': '65 mins',
    },
  ];

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning, Alex!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Ready to crush your workout?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Stats Grid
              Text(
                'Your Stats',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildStatCard(
                    '🔥 Workout Streak',
                    '${stats['workoutStreak']} days',
                    Icons.local_fire_department,
                  ),
                  _buildStatCard(
                    '📅 Weekly Workouts',
                    '${stats['weeklyWorkouts']} completed',
                    Icons.check_circle,
                  ),
                  _buildStatCard(
                    '🔥 Calories Burned',
                    '${stats['caloriesBurned']} cal',
                    Icons.whatshot,
                  ),
                  _buildStatCard(
                    '⏱️ Workout Time',
                    stats['workoutTime'],
                    Icons.timer,
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Upcoming Workouts
              Text(
                'Upcoming Workouts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ...upcomingWorkouts.map(
                (workout) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.fitness_center, color: Colors.blue),
                    ),
                    title: Text(workout['name']),
                    subtitle: Text(workout['time']),
                    trailing: Chip(
                      label: Text(workout['duration']),
                      backgroundColor: Colors.green[50],
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
