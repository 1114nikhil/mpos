import 'package:flutter/material.dart';
import 'package:mpos/core/utils/responsive_utils.dart';
import 'package:mpos/core/widgets/ult_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Get responsive configurations
          final config = ResponsiveUtils.getResponsiveConfig(context);

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: config.maxContentWidth),
              child: Container(
                color: Colors.grey[100],
                padding: EdgeInsets.all(config.padding),
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
                          padding: EdgeInsets.all(config.padding),
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
                                      fontSize: 20 * config.fontSizeMultiplier,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Here’s your overview',
                                    style: TextStyle(
                                      fontSize: 16 * config.fontSizeMultiplier,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.analytics,
                                size: 32 * config.fontSizeMultiplier,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: config.padding),

                      // Stats Grid
                      Text(
                        'Quick Stats',
                        style: TextStyle(
                          fontSize: 18 * config.fontSizeMultiplier,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: config.padding / 2),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: config.crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: config.childAspectRatio,
                        children: [
                          UltCard(
                            title: 'Customer',
                            value: '',
                            icon: Icons.people,
                            color: Colors.blue,
                            fontSizeMultiplier: config.fontSizeMultiplier,
                          ),
                          UltCard(
                            title: 'Items',
                            value: '',
                            icon: Icons.inventory,
                            color: Colors.purple,
                           fontSizeMultiplier: config.fontSizeMultiplier,
                          ),
                          UltCard(
                            title: 'Orders',
                            value: '',
                            icon: Icons.shopping_cart,
                            color: Colors.orange,
                            fontSizeMultiplier: config.fontSizeMultiplier,
                          ),
                          UltCard(
                            title: 'Sales',
                            value: '',
                            icon: Icons.monetization_on,
                            color: Colors.green,
                            fontSizeMultiplier: config.fontSizeMultiplier,
                          ),
                          UltCard(
                            title: 'More',
                            value: '',
                            icon: Icons.menu,
                            color: Colors.green,
                            fontSizeMultiplier: config.fontSizeMultiplier,
                          ),
                        ],
                      ),
                      SizedBox(height: config.padding),

                      // Recent Activity
                      Text(
                        'Recent Activity',
                        style: TextStyle(
                          fontSize: 18 * config.fontSizeMultiplier,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: config.padding / 2),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final activities = [
                              {
                                'title': 'New User Registered',
                                'time': '2 hours ago'
                              },
                              {
                                'title': 'Order #1234 Completed',
                                'time': '4 hours ago'
                              },
                              {
                                'title': 'Task Assigned',
                                'time': '6 hours ago'
                              },
                            ];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal[100],
                                child: const Icon(Icons.event, color: Colors.teal),
                              ),
                              title: Text(
                                activities[index]['title']!,
                                style:
                                    TextStyle(fontSize: 16 * config.fontSizeMultiplier),
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
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        child: const Icon(Icons.chat),
      ),
    );
  }
}