import 'package:data/injector.dart' as data;
import 'package:domain/injector.dart' as domain;
import 'package:get_it/get_it.dart';

Future<void> initDi({required GetIt get}) async {
  await data.configureDependencies(get);
  domain.configureDependencies(get);
}
