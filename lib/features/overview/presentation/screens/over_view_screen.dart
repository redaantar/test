import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/core/UI/loading_widget.dart';
import '../../../../core/UI/custom_bottom_nav_bar.dart';
import '../../../../core/UI/error_widget.dart';
import '../provider/overview_provider.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/info_cards_widget.dart';
import '../widgets/observation_chart_widget.dart';
import '../widgets/progress_chart_widget.dart';
import 'manual_alert_screen.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OverviewProvider>(context, listen: false).getOverview();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Overview', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=10'),
              backgroundColor: Colors.grey[300],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<OverviewProvider>(
          builder: (context, overViewProvider, child) {
            if (overViewProvider.isLoading) {
              return const LoadingWidget();
            } else if (overViewProvider.isError) {
              return CustomErrorWidget(onPressed: () => overViewProvider.getOverview);
            } else if (overViewProvider.overview != null) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCardsWidget(summary: overViewProvider.overview!.statusSummary),
                    _buildChipSection(),
                    ObservationChartWidget(
                      observationsChartModel: overViewProvider.overview!.observationsChart,
                      onFilterIconTap: () => showFilterBottomSheet(context),
                    ),
                    ProgressChartWidget(
                      progressChartModel: overViewProvider.overview!.progressChart,
                      onFilterIconTap: () => showFilterBottomSheet(context),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 4) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManualAlertScreen()));
            }
          });
        },
      ),
    );
  }

  Widget _buildChipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Quick Filters',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 10),
              _buildChip('Daily'),
              _buildChip('Safety'),
              _buildChip('Excellent'),
              _buildChip('Bad condition'),
            ].map((chip) => Padding(padding: const EdgeInsets.only(right: 5), child: chip)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      side: BorderSide(
        color: Colors.black.withOpacity(0.1),
        width: 0.3,
      ),
      label: Text(label),
      backgroundColor: Colors.white,
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: () {},
    );
  }

}