import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:indragram/my_widget/my_widget.snackbar.dart';

class CartController extends GetxController {
  // Example properties for the cart
  final CartController cartController = Get.find<CartController>();
  final RxList<String> items = <String>[].obs;
  final RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the cart with some data if needed
    fetchCartItems();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Example method to fetch cart items
  void fetchCartItems() {
    // Fetch items from a service or database
    // For now, let's add some dummy items
    items.addAll(['Item 1', 'Item 2', 'Item 3']);
    calculateTotalPrice();
  }

  // Example method to calculate total price
  void calculateTotalPrice() {
    // Calculate the total price of items in the cart
    // For now, let's assume each item costs 10.0
    totalPrice.value = items.length * 10.0;
  }

  // Example method to add an item to the cart
  void addItem(String item) {
    items.add(item);
    calculateTotalPrice();
  }

  // Example method to remove an item from the cart
  void removeItem(String item) {
    items.remove(item);
    calculateTotalPrice();
  }
}
