// home_page.dart
import 'package:flutter/material.dart';
import 'package:gym_app/second%20try/pages/dash_board.dart';
import 'package:gym_app/second%20try/pages/excercise.dart';
import 'package:gym_app/second%20try/pages/profile.dart';
import 'package:gym_app/second%20try/pages/progress_tract.dart';
import 'package:gym_app/second%20try/pages/workout.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({super.key});

  @override
  _HomePageNewState createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    WorkoutPlanPage(),
    ExercisesPage(),
    ProgressPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Exercises'),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Progress',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
