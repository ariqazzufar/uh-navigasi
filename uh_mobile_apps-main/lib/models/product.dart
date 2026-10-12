import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final int price;
  final String imageUrl;
  final IconData fallbackIcon;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.fallbackIcon,
    this.description = '',
  });
}
