import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_form_fields/smart_form_fields.dart';

class AuthController extends GetxController {
  RxList<SmartTextFieldViewItem> formFieldViewItems = .new([]);
  RxBool useVinCode = .new(true);

  void initViewItems() {
    formFieldViewItems.value = [
      SmartTextFieldViewItem(
        name: 'make',
        decoration: const InputDecoration(labelText: 'Make', hintText: 'e.g. Toyota, BMW'),
        validators: [SmartValidators.required(message: 'Make is required')],
      ),
      SmartTextFieldViewItem(
        name: 'model',
        decoration: const InputDecoration(labelText: 'Model', hintText: 'e.g. Camry, 3 Series'),
        validators: [SmartValidators.required(message: 'Model is required')],
      ),
      SmartTextFieldViewItem(
        name: 'year',
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Year', hintText: 'e.g. 2022'),
        validators: [
          SmartValidators.required(message: 'Year is required'),
          SmartValidators.number(message: 'Please enter a valid year'),
        ],
      ),
      SmartTextFieldViewItem(
        name: 'body_type',
        decoration: const InputDecoration(labelText: 'Body Type', hintText: 'e.g. Sedan, SUV, Coupe, Hatchback'),
      ),
    ];
  }
}
