import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Import all pages (we'll create these in the next groups)
import '../../features/onboarding/presentation/pages/welcome_page.dart';
import '../../features/onboarding/presentation/pages/community_powered_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/create_account_page.dart';
import '../../features/auth/presentation/pages/phone_verification_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/price_comparison/presentation/pages/search_page.dart';
import '../../features/price_comparison/presentation/pages/product_details_page.dart';
import '../../features/price_submission/presentation/pages/add_price_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/user_submissions_page.dart';
import '../../features/profile/presentation/pages/saved_products_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/vendor_discovery/presentation/pages/vendor_list_page.dart';
import '../../features/vendor_discovery/presentation/pages/vendor_details_page.dart';
import '../../features/vendor_discovery/presentation/pages/vendor_map_page.dart';
import '../../features/shopping_list/presentation/pages/shopping_list_page.dart';
import '../../features/shopping_list/presentation/pages/create_list_page.dart';
import '../../features/shopping_list/presentation/pages/budget_tracker_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Onboarding Screens (1-2)
      GoRoute(
        path: '/',
        name: 'welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/community-powered',
        name: 'community-powered',
        builder: (context, state) => const CommunityPoweredPage(),
      ),
      
      // Authentication Screens (3-5)
      GoRoute(
        path: '/sign-in',
        name: 'sign-in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/create-account',
        name: 'create-account',
        builder: (context, state) => const CreateAccountPage(),
      ),
      GoRoute(
        path: '/phone-verification',
        name: 'phone-verification',
        builder: (context, state) => PhoneVerificationPage(
          phoneNumber: state.extra as String? ?? '',
        ),
      ),
      
      // Main App Screens (6-12)
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/product-details/:productId',
        name: 'product-details',
        builder: (context, state) => ProductDetailsPage(
          productId: state.pathParameters['productId']!,
        ),
      ),
      GoRoute(
        path: '/add-price',
        name: 'add-price',
        builder: (context, state) => const AddPricePage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      
      // Additional Screens (13-21)
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/vendor-list',
        name: 'vendor-list',
        builder: (context, state) => const VendorListPage(),
      ),
      GoRoute(
        path: '/vendor-details/:vendorId',