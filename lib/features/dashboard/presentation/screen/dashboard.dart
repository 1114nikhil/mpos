import 'package:flutter/material.dart';
import 'package:mpos/core/widgets/ult_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.teal, Colors.tealAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Here’s your overview',
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.analytics,
                        size: isTablet ? 40 : 32,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Stats Grid
              Text(
                'Quick Stats',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isTablet ? 3 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isTablet ? 1.2 : 1.0,
                children: [
                  UltCard(
                    title: 'Users',
                    value: '1,234',
                    icon: Icons.people,
                    color: Colors.blue,
                    isTablet: isTablet,
                  ),
                  UltCard(
                    title: 'Sales',
                    value: '\$5,678',
                    icon: Icons.monetization_on,
                    color: Colors.green,
                    isTablet: isTablet,
                  ),
                  UltCard(
                    title: 'Orders',
                    value: '89',
                    icon: Icons.shopping_cart,
                    color: Colors.orange,
                    isTablet: isTablet,
                  ),
                  UltCard(
                    title: 'Tasks',
                    value: '23',
                    icon: Icons.task,
                    color: Colors.purple,
                    isTablet: isTablet,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Recent Activity
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final activities = [
                      {'title': 'New User Registered', 'time': '2 hours ago'},
                      {'title': 'Order #1234 Completed', 'time': '4 hours ago'},
                      {'title': 'Task Assigned', 'time': '6 hours ago'},
                    ];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[100],
                        child: const Icon(Icons.event, color: Colors.teal),
                      ),
                      title: Text(
                        activities[index]['title']!,
                        style: TextStyle(fontSize: isTablet ? 18 : 16),
                      ),
                      subtitle: Text(activities[index]['time']!),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}