import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_domain/smart_domain.dart';

/// Shared GetX lifecycle, use-case lookup and operation-specific loading.
/// Controllers belong to GetX/views; only domain/data dependencies use GetIt.
abstract class BaseController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final RxList<String> _pendingIds = <String>[].obs;
  RxList<String> get getPendingKeys => _pendingIds;
  bool get active => !isClosed;

  bool containPendingKey(String key) => _pendingIds.contains(key);
  T getInstance<T extends Object>() => GetIt.instance.get<T>();

  void addPendingIds(List<String> keys) {
    if (!active) return;
    _pendingIds.addAll(keys.where((key) => !_pendingIds.contains(key)));
  }

  void removePendingIds(List<String> keys) =>
      _pendingIds.removeWhere(keys.contains);
  void startLoading(List<String> keys) => addPendingIds(keys);
  void stopLoading(List<String> keys) => removePendingIds(keys);

  /// Exceptions propagate to the caller; loading always clears in finally.
  Future<R> runPending<R>(String key, Future<R> Function() action) async {
    addPendingIds([key]);
    try {
      return await action();
    } finally {
      removePendingIds([key]);
    }
  }

  Future<R> launchUseCaseNoParams<R>(
    NoParamsFutureUseCase<R> useCase,
    String pendingKey,
  ) => runPending(pendingKey, useCase.call);

  Future<R> launchUseCase<R, P>(
    FutureUseCase<R, P> useCase,
    P params,
    String pendingKey,
  ) => runPending(pendingKey, () => useCase(params));

  @override
  void onClose() {
    _pendingIds.clear();
    super.onClose();
  }

  @override
  void onResumed() {}
  @override
  void onPaused() {}
  @override
  void onHidden() {}
  @override
  void onInactive() {}
  @override
  void onDetached() {}
}
