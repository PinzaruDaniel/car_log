import 'package:flutter/material.dart';
import 'package:flutter_wallet_kit/flutter_wallet_kit.dart';

import '../utils/apple_wallet_service.dart';

class AppleWalletButton extends StatefulWidget {
  const AppleWalletButton({super.key});

  @override
  State<AppleWalletButton> createState() => _AppleWalletButtonState();
}

class _AppleWalletButtonState extends State<AppleWalletButton> {
  final _service = const AppleWalletService();

  bool _loading = false;
  bool _alreadyAdded = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final status = await _service.getPassStatus();

    if (!mounted) return;

    setState(() {
      _alreadyAdded = status == WalletPassStatus.added;
    });
  }

  Future<void> _addPass() async {
    if (_loading) return;

    setState(() => _loading = true);

    try {
      final result = await _service.addPass();

      if (!mounted) return;

      switch (result) {
        case WalletResult.success:
        case WalletResult.alreadyAdded:
          setState(() => _alreadyAdded = true);
          break;

        case WalletResult.cancelled:
          break;

        default:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wallet error: ${result.name}')));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_alreadyAdded) {
      return const Text('Already added to Apple Wallet');
    }

    if (_loading) {
      return const CircularProgressIndicator();
    }

    return SizedBox(width: 220, height: 48, child: AddToAppleWalletButton(onPressed: _addPass));
  }
}
