import '../../controllers/base/base_controller.dart';
import '../../localization/localization.dart';
import '../../view_models/garage_vehicle_view_model.dart';
import '../../widgets/garage_widgets.dart';

class AnalyticsController extends BaseController {
  AnalyticsViewItem buildViewItem(
    GarageVehicleViewModel vehicle,
  ) => AnalyticsViewItem(
    categories: ServiceKindViewModel.values
        .map(
          (kind) => AnalyticsCategoryViewItem(
            label: switch (kind) {
              ServiceKindViewModel.maintenance => LocaleKeys.maintenance.tr(),
              ServiceKindViewModel.repair => LocaleKeys.repairs.tr(),
              ServiceKindViewModel.fuel => LocaleKeys.fuel.tr(),
            }.toUpperCase(),
            cost: money(
              vehicle.records
                  .where((record) => record.kind == kind)
                  .fold(0.0, (sum, record) => sum + record.cost),
            ),
            recordCount: LocaleKeys.records_count.tr(
              namedArgs: {
                'count':
                    '${vehicle.records.where((record) => record.kind == kind).length}',
              },
            ),
          ),
        )
        .toList(growable: false),
  );
}

class AnalyticsViewItem {
  const AnalyticsViewItem({required this.categories});

  final List<AnalyticsCategoryViewItem> categories;
}

class AnalyticsCategoryViewItem {
  const AnalyticsCategoryViewItem({
    required this.label,
    required this.cost,
    required this.recordCount,
  });

  final String label;
  final String cost;
  final String recordCount;
}
