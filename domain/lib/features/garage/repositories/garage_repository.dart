import '../entities/garage_vehicle.dart';

abstract interface class GarageRepository {
  Future<GarageVehicleEntity?> load();
  Future<void> save(GarageVehicleEntity vehicle);
  Future<Map<String, String>> decodeVin(String vin);
}
