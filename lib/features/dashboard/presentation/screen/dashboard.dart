import 'package:flutter/material.dart';
import 'package:mpos/core/utils/responsive_utils.dart';
import 'package:mpos/core/widgets/ult_floating_action_button.dart';
import 'package:mpos/features/dashboard/presentation/widget/quick_stats_section.dart';
import 'package:mpos/features/dashboard/presentation/widget/recent_activity_section.dart';
import 'package:mpos/features/dashboard/presentation/widget/search_field.dart';
import 'package:mpos/features/dashboard/presentation/widget/welcome_toaster.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showToaster = true;

  @override
  void initState() {
    super.initState();
    // Optionally, reset _showToaster on screen reload if needed
  }

  void _onToasterDismissed() {
    setState(() {
      _showToaster = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Compute responsive config once
    final config = ResponsiveUtils.getResponsiveConfig(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: const [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: null, // Disabled for now
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: null, // Disabled for now
          ),
        ],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
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
                          SearchField(config: config),
                          SizedBox(height: config.padding),
                          QuickStatsSection(config: config),
                          SizedBox(height: config.padding),
                          RecentActivitySection(config: config),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (_showToaster)
            WelcomeToaster(
              config: config,
              onDismissed: _onToasterDismissed,
            ),
        ],
      ),
      floatingActionButton: UltFloatingActionButton(
        onPressed: () {},
        icon: Icons.chat_bubble_outline_rounded,
        backgroundColor: Colors.teal,
        fontSizeMultiplier: config.fontSizeMultiplier,
        padding: config.padding,
        tooltip: 'Chat',
      ),
    );
  }
}