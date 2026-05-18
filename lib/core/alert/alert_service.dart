import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AlertType { error, success, warning, info, system }

class Alert {
  final AlertType type;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool dismissible;

  Alert({
    required this.type,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.dismissible = true,
  });
}

class AlertService {
  final List<Alert> _alerts = [];
  final _alertController = AlertController();

  AlertController get controller => _alertController;

  List<Alert> get alerts => List.unmodifiable(_alerts);

  void show({
    required AlertType type,
    required String title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
  }) {
    final alert = Alert(
      type: type,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
    );
    _alerts.add(alert);
    _alertController.notifyAlert();
  }

  void dismiss() {
    _alerts.clear();
    _alertController.notifyAlert();
  }

  void removeAt(int index) {
    if (index >= 0 && index < _alerts.length) {
      _alerts.removeAt(index);
      _alertController.notifyAlert();
    }
  }
}

class AlertController extends ChangeNotifier {
  void notifyAlert() {
    notifyListeners();
  }
}

final alertServiceProvider = Provider<AlertService>((ref) {
  return AlertService();
});