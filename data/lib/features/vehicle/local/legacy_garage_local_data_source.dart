import 'dart:convert';
import 'dart:io';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

/// One-time import of garages saved by the earlier JSON implementation.
/// The original file is retained after importing into ObjectBox.
@lazySingleton
class LegacyGarageLocalDataSource {
  Future<GarageVehicle?> load() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/garage.json');
    if (!await file.exists()) return null;
    return GarageVehicle.fromJson(
      jsonDecode(await file.readAsString()) as Map<String, dynamic>,
    );
  }
}
