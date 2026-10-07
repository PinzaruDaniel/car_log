enum ServiceKindViewModel { maintenance, repair, fuel }

class ServiceRecordViewModel {
  const ServiceRecordViewModel({
    required this.title,
    required this.date,
    required this.km,
    required this.kind,
    required this.cost,
    required this.notes,
    required this.oil,
  });

  final String title;
  final DateTime date;
  final int km;
  final ServiceKindViewModel kind;
  final double cost;
  final String notes;
  final bool oil;
}

class GarageVehicleViewModel {
  const GarageVehicleViewModel({
    required this.make,
    required this.model,
    required this.year,
    required this.odometer,
    required this.vin,
    required this.body,
    required this.fuel,
    required this.engine,
    required this.oilInterval,
    required this.insuranceExpiry,
    required this.records,
  });

  final String make;
  final String model;
  final int year;
  final int odometer;
  final String vin;
  final String body;
  final String fuel;
  final String engine;
  final int oilInterval;
  final DateTime? insuranceExpiry;
  final List<ServiceRecordViewModel> records;

  String get title => '$make $model';
}
