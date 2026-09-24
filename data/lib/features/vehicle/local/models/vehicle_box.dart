import 'package:objectbox/objectbox.dart';

@Entity()
class VehicleBox {
  VehicleBox({
    this.id = 0,
    this.remoteId = '',
  });

  @Id()
  int id;

  String remoteId;
}
