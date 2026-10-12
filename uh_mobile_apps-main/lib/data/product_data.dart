import 'package:flutter/material.dart';
import '../models/product.dart';

const List<Product> sampleProducts = [
  Product(
    id: 'prod_1',
    name: 'Wireless Headphones ANC',
    category: 'Audio',
    price: 100000,
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=350&auto=format&fit=crop&q=60',
    fallbackIcon: Icons.headphones,
    description: 'Headphone nirkabel dengan teknologi active noise cancelling untuk pengalaman audio yang imersif dan jernih.',
  ),
  Product(
    id: 'prod_2',
    name: 'Smartwatch Active Pro',
    category: 'Wearable',
    price: 250000,
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=350&auto=format&fit=crop&q=60',
    fallbackIcon: Icons.watch,
    description: 'Smartwatch multifungsi dengan pelacak detak jantung, monitor kebugaran, dan layar AMOLED berdaya tahan tinggi.',
  ),
  Product(
    id: 'prod_3',
    name: 'Mechanical Gaming Keyboard',
    category: 'Aksesoris PC',
    price: 500000,
    imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=350&auto=format&fit=crop&q=60',
    fallbackIcon: Icons.keyboard,
    description: 'Keyboard mekanikal dengan RGB backlit responsif, switch tactile premium, dan desain ergonomis untuk produktivitas maksimal.',
  ),
  Product(
    id: 'prod_4',
    name: 'Smartphone Ultra 5G',
    category: 'Smartphone',
    price: 1000000,
    imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=350&auto=format&fit=crop&q=60',
    fallbackIcon: Icons.phone_android,
    description: 'Smartphone performa tinggi dengan konektivitas 5G kilat, kamera profesional 64MP, dan baterai tahan seharian.',
  ),
  Product(
    id: 'prod_5',
    name: 'Portable Bluetooth Speaker',
    category: 'Audio',
    price: 200000,
    imageUrl: 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=350&auto=format&fit=crop&q=60',
    fallbackIcon: Icons.speaker,
    description: 'Speaker portabel tahan air dengan bass bertenaga dan koneksi Bluetooth stabil untuk aktivitas luar ruangan.',
  ),
  Product(
    id: 'prod_6',
    name: 'Laptop Slim 14 Inch',
    category: 'Laptop',
    price: 2000000,
    imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=350&auto=format&fit=crop&q=60',
    fallbackIcon: Icons.laptop_mac,
    description: 'Laptop tipis dan ringan bertenaga prosesor generasi terbaru, cocok untuk pelajar dan profesional muda.',
  ),
];
