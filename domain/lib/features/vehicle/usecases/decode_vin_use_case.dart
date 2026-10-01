import 'package:smart_domain/smart_domain.dart';
import '../../garage/repositories/garage_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DecodeVinUseCase
    extends ResultUseCase<Map<String, String>, String, String> {
  const DecodeVinUseCase(this.repository);
  final GarageRepository repository;

  @override
  Future<Result<Map<String, String>, String>> execute(String params) async {
    final vin = params.trim().toUpperCase();
    if (!RegExp(r'^[A-HJ-NPR-Z0-9]{17}$').hasMatch(vin)) {
      return const FailureResult('vin_invalid');
    }
    return Result.guardAsync(
      () => repository.decodeVin(vin),
      onError: (_, _) => 'vin_unavailable',
    );
  }
}
