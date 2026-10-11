import 'package:flutter/services.dart';
import 'package:flutter_wallet_kit/flutter_wallet_kit.dart';

class AppleWalletService {
  const AppleWalletService();

  static const FlutterWalletKit _wallet = FlutterWalletKit();

  Future<Uint8List> _loadPass() async {
    final data = await rootBundle.load('assets/wallet/MyVehicleCard.pkpass');

    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<bool> isSupported() async {
    return _wallet.isWalletSupported();
  }

  Future<WalletPassStatus> getPassStatus() async {
    final bytes = await _loadPass();

    return _wallet.getPassStatus(iosPassData: bytes);
  }

  Future<WalletResult> addPass() async {
    final supported = await isSupported();

    if (!supported) {
      return WalletResult.walletUnavailable;
    }

    final bytes = await _loadPass();

    return _wallet.addPass(iosPassData: bytes);
  }
}
