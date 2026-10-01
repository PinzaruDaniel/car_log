import 'package:objectbox/objectbox.dart';

@Entity()
class ServiceRecordBox {
  ServiceRecordBox({
    this.id = 0,
    required this.title,
    required this.date,
    required this.km,
    required this.kindName,
    this.cost = 0,
    this.notes = '',
    this.oil = false,
  });
  @Id()
  int id;
  String title, kindName, notes;
  @Property(type: PropertyType.date)
  DateTime date;
  int km;
  double cost;
  bool oil;
}
