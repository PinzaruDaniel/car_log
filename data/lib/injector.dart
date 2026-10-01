import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies(GetIt get) async {
  await get.init();
}
