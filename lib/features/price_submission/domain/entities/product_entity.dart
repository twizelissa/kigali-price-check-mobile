import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String name;
  final String category;
  final String brand;
  final String model;
  final String? specifications;
  final String? imageUrl;
  final DateTime createdAt;
  final String? createdBy;
  final List<String> tags;
  final bool active;
  final double? averagePrice;
  final String? barcode;

  const ProductEntity({
    required this.productId,
    required this.name,
    required this.category,
    required this.brand,
    required this.model,
    this.specifications,
    this.imageUrl,
    required this.createdAt,
    this.createdBy,
    this.tags = const [],
    this.active = true,
    this.averagePrice,
    this.barcode,
  });

  factory ProductEntity.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductEntity(
      productId: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      brand: data['brand'] ?? '',
      model: data['model'] ?? '',
      specifications: data['specifications'],
      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      createdBy: data['createdBy'],
      tags: List<String>.from(data['tags'] ?? []),
      active: data['active'] ?? true,
      averagePrice: data['averagePrice']?.toDouble(),
      barcode: data['barcode'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'brand': brand,
      'model': model,
      'specifications': specifications,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      'tags': tags,
      'active': active,
      'averagePrice': averagePrice,
      'barcode': barcode,
    };
  }

  ProductEntity copyWith({
    String? productId,
    String? name,
    String? category,
    String? brand,
    String? model,
    String? specifications,
    String? imageUrl,
    DateTime? createdAt,
    String? createdBy,
    List<String>? tags,
    bool? active,
    double? averagePrice,
    String? barcode,
  }) {
    return ProductEntity(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      specifications: specifications ?? this.specifications,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      tags: tags ?? this.tags,
      active: active ?? this.active,
      averagePrice: averagePrice ?? this.averagePrice,
      barcode: barcode ?? this.barcode,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        name,
        category,
        brand,
        model,
        specifications,
        imageUrl,
        createdAt,
        createdBy,
        tags,
        active,
        averagePrice,
        barcode,
      ];
}

// Electronics Categories Enum
enum ElectronicsCategory {
  smartphones('Smartphones'),
  laptops('Laptops'),
  tablets('Tablets'),
  computers('Computers'),
  accessories('Accessories'),
  headphones('Headphones'),
  speakers('Speakers'),
  monitors('Monitors'),
  keyboards('Keyboards'),
  mice('Mice'),
  chargers('Chargers'),
  cables('Cables'),
  cases('Cases'),
  others('Others');

  const ElectronicsCategory(this.displayName);
  final String displayName;
}

// Popular Electronics Brands
class ElectronicsBrands {
  static const List<String> smartphoneBrands = [
    'Apple',
    'Samsung',
    'Huawei',
    'Xiaomi',
    'Oppo',
    'Vivo',
    'OnePlus',
    'Google',
    'Nokia',
    'Infinix',
    'Tecno',
    'Itel',
  ];

  static const List<String> laptopBrands = [
    'Apple',
    'Dell',
    'HP',
    'Lenovo',
    'Asus',
    'Acer',
    'MSI',
    'Microsoft',
    'Toshiba',
    'Sony',
  ];

  static const List<String> accessoryBrands = [
    'Apple',
    'Samsung',
    'Sony',
    'JBL',
    'Beats',
    'Bose',
    'Anker',
    'Belkin',
    'Logitech',
    'Razer',
  ];

  static List<String> getBrandsForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'smartphones':
        return smartphoneBrands;
      case 'laptops':
        return laptopBrands;
      case 'accessories':
      case 'headphones':
      case 'speakers':
        return accessoryBrands;
      default:
        return [...smartphoneBrands, ...laptopBrands, ...accessoryBrands]
            .toSet()
            .toList();
    }
  }
}