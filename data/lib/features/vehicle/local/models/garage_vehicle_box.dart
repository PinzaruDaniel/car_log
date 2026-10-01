import 'package:objectbox/objectbox.dart';
import 'service_record_box.dart';

@Entity()
class GarageVehicleBox {
  GarageVehicleBox({
    this.id = 0,
    required this.make,
    required this.model,
    required this.year,
    required this.odometer,
    this.vin = '',
    this.body = '',
    this.fuel = '',
    this.engine = '',
    this.oilInterval = 10000,
    this.insuranceExpiry,
  });

  @Id()
  int id;
  String make, model, vin, body, fuel, engine;
  int year, odometer, oilInterval;
  @Property(type: PropertyType.date)
  DateTime? insuranceExpiry;
  final records = ToMany<ServiceRecordBox>();
}
