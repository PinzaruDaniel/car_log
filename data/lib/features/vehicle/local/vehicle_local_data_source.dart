import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

import 'models/vehicle_box.dart';

abstract class VehicleLocalDataSource {
  Future<void> cacheItems(List<Object> items);
}

@LazySingleton(as: VehicleLocalDataSource)
class VehicleLocalDataSourceImpl implements VehicleLocalDataSource {
  const VehicleLocalDataSourceImpl(this._box);

  final Box<VehicleBox> _box;
  Box<VehicleBox> get box => _box;

  static VehicleLocalDataSource init(Store store) {
    return VehicleLocalDataSourceImpl(Box<VehicleBox>(store));
  }

  @override
  Future<void> cacheItems(List<Object> items) async {
    // TODO: Convert vehicle items to VehicleBox and cache them.
  }
}
