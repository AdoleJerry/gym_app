// models/dummy_data.dart
class DummyData {
  static final List<Workout> workouts = [
    Workout(
      name: 'Morning Cardio',
      duration: 30,
      calories: 250,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Workout(
      name: 'Strength Training',
      duration: 60,
      calories: 350,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Workout(
      name: 'Yoga',
      duration: 45,
      calories: 200,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  static final List<Exercise> exercises = [
    Exercise(
      name: 'Push-ups',
      category: 'Chest',
      equipment: 'Bodyweight',
      difficulty: 'Beginner',
    ),
    Exercise(
      name: 'Squats',
      category: 'Legs',
      equipment: 'Bodyweight',
      difficulty: 'Beginner',
    ),
    Exercise(
      name: 'Plank',
      category: 'Abs',
      equipment: 'Bodyweight',
      difficulty: 'Beginner',
    ),
  ];
}

class Workout {
  final String name;
  final int duration;
  final int calories;
  final DateTime date;

  Workout({
    required this.name,
    required this.duration,
    required this.calories,
    required this.date,
  });
}

class Exercise {
  final String name;
  final String category;
  final String equipment;
  final String difficulty;

  Exercise({
    required this.name,
    required this.category,
    required this.equipment,
    required this.difficulty,
  });
}
