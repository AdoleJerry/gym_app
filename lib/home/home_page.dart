import 'package:flutter/material.dart';
import 'package:gym_app/auth/auth.dart';
import 'package:gym_app/home/acccount_page.dart';
import 'package:gym_app/home/notifications.dart';
import 'package:gym_app/home/quick_actions.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  final CustomUser? user;

  const HomePage({super.key, this.user});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeDashboard());
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top App Bar
              _buildAppBar(context),
              const SizedBox(height: 20),

              // Daily Summary Card
              _buildDailySummaryCard(),
              const SizedBox(height: 25),

              // Quick Actions
              _buildQuickActions(),
              const SizedBox(height: 25),

              // Recommended Workouts
              _buildRecommendedWorkouts(),
              const SizedBox(height: 25),

              // Motivation Section
              _buildMotivationSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AccountPage()),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              const Text(
                "User's Name",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => NotificationScreen(),
                      ),
                    );
                  },
                  icon: Icon(Iconsax.notification, size: 24),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () => _navigateToAccount(context),
                  icon: Icon(
                    Iconsax.profile_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailySummaryCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(
                  icon: Iconsax.like,
                  value: "820",
                  unit: "kcal",
                  label: "Calories",
                  color: Colors.orange,
                ),
                _buildStatItem(
                  icon: Iconsax.clock,
                  value: "45",
                  unit: "min",
                  label: "Workout",
                  color: Colors.blue,
                ),
                _buildStatItem(
                  icon: Iconsax.stop,
                  value: "8,256",
                  unit: "steps",
                  label: "Steps",
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Progress Ring
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: 0.75,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.deepPurple,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "75%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      "Daily Goal",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String unit,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(text: value),
              TextSpan(
                text: " $unit",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildQuickActions() {
    const List<QuickActionItem> actions = [
      QuickActionItem(
        icon: Iconsax.play_circle,
        label: "Begin Workoout",
        color: Colors.deepPurple,
      ),
      QuickActionItem(
        icon: Iconsax.activity,
        label: "Exercises",
        color: Colors.blue,
      ),
      QuickActionItem(
        icon: Iconsax.chart_square,
        label: "Progress",
        color: Colors.green,
      ),
      QuickActionItem(
        icon: Iconsax.cake,
        label: "Meal Plan",
        color: Colors.orange,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 100,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                childAspectRatio: 0.85,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                return _buildQuickActionCard(actions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(QuickActionItem action) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(action.icon, color: action.color, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            action.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedWorkouts() {
    final List<Workout> workouts = [
      Workout(
        name: "Morning Yoga Flow",
        difficulty: "Beginner",
        duration: "15 min",
        image: "assets/yoga.jpg",
        color: Colors.purple,
      ),
      Workout(
        name: "HIIT Burn",
        difficulty: "Advanced",
        duration: "20 min",
        image: "assets/hiit.jpg",
        color: Colors.orange,
      ),
      Workout(
        name: "Full Body Strength",
        difficulty: "Intermediate",
        duration: "30 min",
        image: "assets/strength.jpg",
        color: Colors.blue,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended Workouts",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: workouts.length,
              separatorBuilder: (_, _) => const SizedBox(width: 15),
              itemBuilder: (context, index) {
                return _buildWorkoutCard(workouts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(Workout workout) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: workout.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: workout.color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: workout.color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    workout.difficulty,
                    style: TextStyle(
                      color: workout.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  workout.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Iconsax.clock, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      workout.duration,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: workout.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Iconsax.play,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.withValues(alpha: 0.9),
              Colors.purple.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Iconsax.quote_down, color: Colors.white, size: 28),
            const SizedBox(height: 15),
            const Text(
              "The only bad workout is the one that didn't happen. Every step, every rep, every breath is progress.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Iconsax.profile_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Tip",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Stay hydrated during workouts",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
