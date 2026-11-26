import '../entities/dashboard_stats.dart';

/// Supplies the aggregated numbers shown on the dashboard.
abstract interface class DashboardRepository {
  Stream<DashboardStats> watchStats();
}
