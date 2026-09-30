import 'package:flutter/material.dart';
import 'package:flutter_wallet_kit/flutter_wallet_kit.dart';
import 'package:get/get.dart';
import 'package:car_log/constants/app_constants.dart';
import 'package:car_log/widgets/apple_wallet_button.dart';
import 'package:uuid/uuid.dart';

import '../../controllers/vehicle_controller.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  late final VehicleController controller;

  late final GoogleWalletPass googlePass = GoogleWalletPass.metadata(
    type: GoogleWalletPassType.generic,
    issuerEmail: "google-wallet-backend@carlog-509705.iam.gserviceaccount.com",
    issuerId: AppConstants.issuerId,
    objectId: "${AppConstants.issuerId}.${Uuid().v4()}",
    classId: AppConstants.classId,
    issuedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    values: {
      'hexBackgroundColor': '#6C3BAA',
      'cardTitle': const {
        'defaultValue': {'language': 'en', 'value': 'My personal card'},
      },
      'subheader': const {
        'defaultValue': {'language': 'en', 'value': 'You are just better'},
      },
      'header': const {
        'defaultValue': {'language': 'en', 'value': 'Example pass'},
      },
      'barcode': {'type': 'QR_CODE', 'value': Uuid().v4()},
    },
  );

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddToGoogleWalletButton(
                  pass: googlePass,
                  onSuccess: () => _showSnackBar(context, 'Success!'),
                  onCanceled: () => _showSnackBar(context, 'Action canceled.'),
                  onError: (error) => _showSnackBar(context, error.toString()),
                ),
                SizedBox(width: 8),
                AppleWalletButton(),
              ],
            ),

            /*AddToGoogleWalletButton(pass: _examplePass,
              onSuccess: () => _showSnackBar(context, 'Success!'),
              onCanceled: () => _showSnackBar(context, 'Action canceled.'),
              onError: (Object error) {
              print('onError: ${error.toString()}');
                _showSnackBar(context, error.toString());
              },)*/
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

final int _issuedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

final String _examplePass =
    """
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
