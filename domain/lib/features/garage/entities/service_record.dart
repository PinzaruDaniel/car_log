import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_record.freezed.dart';
part 'service_record.g.dart';

enum ServiceKind { maintenance, repair, fuel }

@freezed
abstract class ServiceRecord with _$ServiceRecord {
  const factory ServiceRecord({
    required String title,
    required DateTime date,
    required int km,
    required ServiceKind kind,
    @Default(0) double cost,
    @Default('') String notes,
    @Default(false) bool oil,
  }) = _ServiceRecord;

  factory ServiceRecord.fromJson(Map<String, dynamic> json) =>
      _$ServiceRecordFromJson(json);
}
