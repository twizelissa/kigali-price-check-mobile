import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String? phoneNumber;
  final String displayName;
  final GeoPoint? location;
  final int reputationScore;
  final Map<String, dynamic> preferences;
  final DateTime createdAt;
  final DateTime lastActiveAt;
  final String role;
  final bool isVerified;
  final String? profileImageUrl;
  final String? address;
  final String? sector;

  const UserEntity({
    required this.userId,
    required this.email,
    this.phoneNumber,
    required this.displayName,
    this.location,
    this.reputationScore = 0,
    this.preferences = const {},
    required this.createdAt,
    required this.lastActiveAt,
    this.role = 'user',
    this.isVerified = false,
    this.profileImageUrl,
    this.address,
    this.sector,
  });

  factory UserEntity.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserEntity(
      userId: doc.id,
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'],
      displayName: data['displayName'] ?? '',
      location: data['location'],
      reputationScore: data['reputationScore'] ?? 0,
      preferences: Map<String, dynamic>.from(data['preferences'] ?? {}),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastActiveAt: (data['lastActiveAt'] as Timestamp).toDate(),
      role: data['role'] ?? 'user',
      isVerified: data['isVerified'] ?? false,
      profileImageUrl: data['profileImageUrl'],
      address: data['address'],
      sector: data['sector'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'location': location,
      'reputationScore': reputationScore,
      'preferences': preferences,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastActiveAt': Timestamp.fromDate(lastActiveAt),
      'role': role,
      'isVerified': isVerified,
      'profileImageUrl': profileImageUrl,
      'address': address,
      'sector': sector,
    };
  }

  UserEntity copyWith({
    String? userId,
    String? email,
    String? phoneNumber,
    String? displayName,
    GeoPoint? location,
    int? reputationScore,
    Map<String, dynamic>? preferences,
    DateTime? createdAt,
    DateTime? lastActiveAt,
    String? role,
    bool? isVerified,
    String? profileImageUrl,
    String? address,
    String? sector,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      location: location ?? this.location,
      reputationScore: reputationScore ?? this.reputationScore,
      preferences: preferences ?? this.preferences,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      address: address ?? this.address,
      sector: sector ?? this.sector,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        email,
        phoneNumber,
        displayName,
        location,
        reputationScore,
        preferences,
        createdAt,
        lastActiveAt,
        role,
        isVerified,
        profileImageUrl,
        address,
        sector,
      ];
}