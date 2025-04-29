import 'package:flutter/material.dart';
import 'package:mpos/core/models/responsive_config.dart';
import 'package:mpos/features/dashboard/presentation/widget/text_style.dart';

class RecentActivitySection extends StatelessWidget {
  final ResponsiveConfig config;

  const RecentActivitySection({super.key,required this.config});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {'title': 'New User Registered', 'time': '2 hours ago'},
      {'title': 'Order #1234 Completed', 'time': '4 hours ago'},
      {'title': 'Task Assigned', 'time': '6 hours ago'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: textStyle(
            fontSize: 18,
            config: config,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: config.padding / 2),
        Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal[100],
                  child: const Icon(Icons.event, color: Colors.teal),
                ),
                title: Text(
                  activities[index]['title']!,
                  style: textStyle(
                    fontSize: 16,
                    config: config,
                  ),
                ),
                subtitle: Text(
                  activities[index]['time']!,
                  style: textStyle(
                    fontSize: 14,
                    config: config,
                    color: Colors.grey[600],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}