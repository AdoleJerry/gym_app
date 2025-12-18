// profile_page.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/auth/auth.dart';
import 'package:gym_app/screens/sign_in_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  // Dummy user data
  final Map<String, dynamic> userProfile = {
    'name': 'Alex Johnson',
    'email': 'alex.johnson@example.com',
    'joinDate': 'November 2025',
    'height': '180 cm',
    'weight': '82 kg',
    'age': 28,
    'gender': 'Male',
    'goal': 'Muscle Building',
    'workoutsCompleted': 42,
    'totalHours': 56,
  };

  final List<Map<String, dynamic>> achievements = [
    {
      'title': '5 Day Streak',
      'icon': Icons.local_fire_department,
      'color': Colors.orange,
    },
    {'title': 'First Workout', 'icon': Icons.flag, 'color': Colors.green},
    {'title': '1000 Reps', 'icon': Icons.fitness_center, 'color': Colors.blue},
    {'title': 'Early Bird', 'icon': Icons.wb_sunny, 'color': Colors.yellow},
  ];

  ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInPage()),
        (route) => false,
      );
    } catch (e) {
      if (kDebugMode) {
        print("error signing out");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue[50],
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/32.jpg',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    userProfile['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    userProfile['email'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Chip(
                    label: Text('Member since ${userProfile['joinDate']}'),
                    backgroundColor: Colors.blue[100],
                  ),
                ],
              ),
            ),

            // Stats
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildProfileStat(
                    'Workouts',
                    '${userProfile['workoutsCompleted']}',
                  ),
                  _buildProfileStat('Hours', '${userProfile['totalHours']}'),
                  _buildProfileStat('Level', 'Intermediate'),
                ],
              ),
            ),

            // Personal Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ..._buildInfoRows([
                    {
                      'icon': Icons.height,
                      'label': 'Height',
                      'value': userProfile['height'],
                    },
                    {
                      'icon': Icons.monitor_weight,
                      'label': 'Weight',
                      'value': userProfile['weight'],
                    },
                    {
                      'icon': Icons.cake,
                      'label': 'Age',
                      'value': '${userProfile['age']} years',
                    },
                    {
                      'icon': Icons.person,
                      'label': 'Gender',
                      'value': userProfile['gender'],
                    },
                    {
                      'icon': Icons.flag,
                      'label': 'Goal',
                      'value': userProfile['goal'],
                    },
                  ]),
                ],
              ),
            ),

            // Achievements
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achievements',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: achievements.map((achievement) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: achievement['color']
                                    .withOpacity(0.2),
                                child: Icon(
                                  achievement['icon'],
                                  color: achievement['color'],
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                achievement['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                  ),
                  child: Text('Logout'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  List<Widget> _buildInfoRows(List<Map<String, dynamic>> info) {
    return info.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(item['icon'], color: Colors.grey),
            SizedBox(width: 16),
            Expanded(child: Text(item['label'])),
            Text(item['value'], style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }).toList();
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: false,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: Text('Workout Reminders'),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: Text('Sound Effects'),
            value: true,
            onChanged: (value) {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
