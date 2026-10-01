import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// Rebuilds for both Rx changes and completed locale-delegate changes.
/// Plain Obx only observes Rx; static `.tr()` reads do not subscribe to locale.
class LocalizedObx extends StatelessWidget {
  const LocalizedObx(this.builder, {super.key});
  final Widget Function() builder;

  @override
  Widget build(BuildContext context) {
    Localizations.localeOf(context);
    return Obx(builder);
  }
}
