class DemoCredentials {
  static const String adminEmail = 'admin@urbania.demo';
  static const String adminPassword = 'Urbania2026!';
  static const String residentEmail = 'residente@urbania.demo';
  static const String residentPassword = 'Residente2026!';

  static bool validate(String email, String password) {
    return (email == adminEmail && password == adminPassword) ||
        (email == residentEmail && password == residentPassword);
  }

  static String getRole(String email) {
    if (email == adminEmail) return 'admin';
    if (email == residentEmail) return 'resident';
    return 'unknown';
  }

  static String getName(String email) {
    if (email == adminEmail) return 'Administrador Demo';
    if (email == residentEmail) return 'Residente Demo';
    return 'Usuario Demo';
  }

  static String getUnit(String email) {
    if (email == adminEmail) return 'Oficina Admin';
    if (email == residentEmail) return 'Apto 101';
    return 'N/A';
  }
}