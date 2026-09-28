import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallet_card/core/wallet_platform.dart';
import 'package:flutter_wallet_card/flutter_wallet_card.dart';
import 'package:flutter_wallet_card/models/wallet_card.dart';
import 'package:get/get.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

import '../../controllers/vehicle_controller.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  late final VehicleController controller;

  @override
  void initState() {
    super.initState();
    Get.put(VehicleController());
    controller = Get.find<VehicleController>();
    controller.load();
  }
  void _showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.items.isEmpty) {
          return Center(
            child: AddToGoogleWalletButton(pass: _examplePass,
              onSuccess: () => _showSnackBar(context, 'Success!'),
              onCanceled: () => _showSnackBar(context, 'Action canceled.'),
              onError: (Object error) {
              print('onError: ${error.toString()}');
                _showSnackBar(context, error.toString());
              },)/*TextButton(
              onPressed: () async {
                var card = WalletCard(
                  id: '${AppConstants.issuerId}.$_passId',
                  type: WalletCardType.generic,
                  platformData: {
                    'issuerId': '3388000000023193615',
                    'classId': '${AppConstants.issuerId}.car_card',
                    "iss": "google-wallet-backend@carlog-509705.iam.gserviceaccount.com",
                    "aud": "google",
                    "typ": "savetowallet",
                    "iat": '$_issuedAt',
                  },
                  metadata: WalletCardMetadata(
                    title: 'My Awesome Card',
                    description: 'This is a sample wallet card',
                    organizationName: 'Your Company',
                    serialNumber: 'CARD123',
                  ),
                );
                bool isAvailable = await FlutterWalletCard.isWalletAvailable;
                if (!isAvailable) {
                  return;
                }
                try {
                  await FlutterWalletCard.addToWallet(card);
                } on WalletException catch (e) {
                  print('Wallet error: ${e.message}');
                  _showSnackBar(context, 'Wallet error: ${e.message}');
                  if (e.originalError != null) {
                    _showSnackBar(context, 'Original error: ${e.originalError.toString()}');
                    print('Original error: ${e.originalError}');
                  }
                } catch (e) {
                  _showSnackBar(context, 'General error: $e');
                  print('General error: $e');
                }
              },
              child: const Text('Add in wallet '),
            ),*/
          );
        }
        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return VehicleViewItem(id: controller.items[index]);
          },
        );
      }),
    );
  }

}

class VehicleViewItem extends StatelessWidget {
  const VehicleViewItem({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(id));
  }
}
final String _passId = const Uuid().v4();

final int _issuedAt =
    DateTime.now().millisecondsSinceEpoch ~/ 1000;

final String _examplePass = """
{
  "iss": "google-wallet-backend@carlog-509705.iam.gserviceaccount.com",
  "aud": "google",
  "typ": "savetowallet",
  "iat": $_issuedAt,
  "origins": [],
  "payload": {
    "genericObjects": [
          {
            "id": "${AppConstants.issuerId}.$_passId",
      "classId": "${AppConstants.issuerId}.car_card",
      "state": "ACTIVE",
            "hexBackgroundColor": "#4285f4",
            
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "My personal card [DEMO ONLY]"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "You are just better"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "OOOOOOO Satalana"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId"
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "67 69",
                "id": "points"
              }
            ]
          }
        ]
  }
} """;
