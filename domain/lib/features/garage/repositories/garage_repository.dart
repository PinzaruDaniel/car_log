import '../entities/garage_vehicle.dart';

abstract interface class GarageRepository {
  Future<GarageVehicle?> load();
  Future<void> save(GarageVehicle vehicle);
  Future<Map<String, String>> decodeVin(String vin);
}
