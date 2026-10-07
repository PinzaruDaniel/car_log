// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceRecordEntity _$ServiceRecordEntityFromJson(Map<String, dynamic> json) =>
    _ServiceRecordEntity(
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      km: (json['km'] as num).toInt(),
      kind: $enumDecode(_$ServiceKindEnumMap, json['kind']),
      cost: (json['cost'] as num?)?.toDouble() ?? 0,
      notes: json['notes'] as String? ?? '',
      oil: json['oil'] as bool? ?? false,
    );

Map<String, dynamic> _$ServiceRecordEntityToJson(
  _ServiceRecordEntity instance,
) => <String, dynamic>{
  'title': instance.title,
  'date': instance.date.toIso8601String(),
  'km': instance.km,
  'kind': _$ServiceKindEnumMap[instance.kind]!,
  'cost': instance.cost,
  'notes': instance.notes,
  'oil': instance.oil,
};

const _$ServiceKindEnumMap = {
  ServiceKind.maintenance: 'maintenance',
  ServiceKind.repair: 'repair',
  ServiceKind.fuel: 'fuel',
};
