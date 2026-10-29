import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumadhura/features/dashboard_screen/widgets/dashboard_action_card.dart';
import 'package:sumadhura/features/dashboard_screen/widgets/dashboard_stat_card.dart';
import 'package:sumadhura/features/register_visitor/register_visitor_bloc/register_visitor_bloc.dart';
import 'package:sumadhura/features/register_visitor/screen/register_visitor_screen.dart';
import 'package:sumadhura/features/visitor/visitor_bloc/visitor_bloc.dart';
import 'package:sumadhura/utils/time_stamp_formats.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onViewVisitors;
  final VoidCallback onScanQr;

  const DashboardScreen({
    super.key,
    required this.onViewVisitors,
    required this.onScanQr,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RegisterVisitorBloc, RegisterVisitorState>(
            listener: (context, state) {
              if (state is EditVisitorSuccessState ||
                  state is RegisterVisitorSuccessState) {
                context.read<VisitorBloc>().add(GetVisitorsEvent());
              }
            },
          ),
          BlocListener<VisitorBloc, VisitorState>(
            listener: (context, state) {
              if (state is DeleteVisitorSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Visitor deleted successfully')),
                );
                context.read<VisitorBloc>().add(GetVisitorsEvent());
              }
            },
          ),
        ],
        child: BlocBuilder<VisitorBloc, VisitorState>(
          builder: (context, state) {
            if (state is VisitorLoadingState || state is VisitorInitialState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VisitorFailureState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(state.errorMessage),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<VisitorBloc>().add(GetVisitorsEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is VisitorSuccessState) {
              final visitors = state.visitors;
              final today = DateTime.now();

              final totalVisitorsToday = visitors.where((visitor) {
                return TimeStampFormats.isToday(visitor.createdAt, today);
              }).length;

              final currentlyCheckedIn = visitors.where((visitor) {
                return visitor.status == 'Checked In';
              }).length;

              final checkedOutToday = visitors.where((visitor) {
                return TimeStampFormats.isToday(visitor.checkOutTime, today);
              }).length;

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<VisitorBloc>().add(GetVisitorsEvent());
                },
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Visitor activity at a glance',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Statistics
                    DashboardStatCard(
                      title: 'Total Visitors Today',
                      value: totalVisitorsToday,
                      icon: Icons.people_outline,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),

                    DashboardStatCard(
                      title: 'Currently Checked In',
                      value: currentlyCheckedIn,
                      icon: Icons.login,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 12),

                    DashboardStatCard(
                      title: 'Checked Out Today',
                      value: checkedOutToday,
                      icon: Icons.logout,
                      color: Colors.orange,
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    DashboardActionCard(
                      title: 'Register Visitor',
                      subtitle: 'Add a new visitor',
                      icon: Icons.person_add_alt_1,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterVisitorScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    DashboardActionCard(
                      title: 'Visitor List',
                      subtitle: 'Search and manage visitors',
                      icon: Icons.people_alt_outlined,
                      onTap: () => onViewVisitors(),
                    ),
                    const SizedBox(height: 12),

                    DashboardActionCard(
                      title: 'Scan QR Code',
                      subtitle: 'Scan a visitor pass',
                      icon: Icons.qr_code_scanner,
                      onTap: () => onScanQr(),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('Unable to load dashboard'));
          },
        ),
      ),
    );
  }
}
