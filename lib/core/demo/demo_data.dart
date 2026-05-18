import '../../auth/domain/entities/resident_entity.dart';
import '../../home/domain/entities/dashboard_metrics.dart';

class DemoData {
  static DashboardMetrics get demoMetrics => DashboardMetrics(
        pendingReservations: 2,
        pendingPayments: 1,
        openPqrs: 3,
        unreadNotifications: 5,
        propertyName: 'Conjunto Residencial Los Pinos',
        propertyAddress: 'Calle 123 # 45-67, Bogotá',
        totalUnits: 48,
      );

  static List<ResidentEntity> get demoResidents => [
        ResidentEntity(
          id: 'usr_admin_001',
          name: 'Administrador Demo',
          email: 'admin@urbania.demo',
          phone: '3001234567',
          unit: 'Oficina Admin',
          avatarUrl: null,
          role: 'admin',
          status: 'active',
          createdAt: DateTime(2024, 1, 1),
        ),
        ResidentEntity(
          id: 'usr_resident_001',
          name: 'Residente Demo',
          email: 'residente@urbania.demo',
          phone: '3007654321',
          unit: 'Apto 101',
          avatarUrl: null,
          role: 'resident',
          status: 'active',
          createdAt: DateTime(2024, 1, 1),
        ),
      ];
}