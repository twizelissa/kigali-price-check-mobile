import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_bottom_navigation.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/trending_price_checks.dart';
import '../widgets/nearby_stores_widget.dart';
import '../widgets/quick_categories_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavBarItem _currentNavItem = NavBarItem.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Row(
          children: [
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                context.go('/notifications');
              },
              icon: Stack(
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textPrimary,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => context.go('/profile'),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: state is AuthAuthenticated && state.user.profileImageUrl != null
                        ? ClipOval(
                            child: Image.network(
                              state.user.profileImageUrl!,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 20,
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                String userName = 'User';
                if (state is AuthAuthenticated) {
                  userName = state.user.displayName.split(' ').first;
                }
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning, $userName! 👋',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Find the best electronics deals in Kigali',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Search Bar
            const SearchBarWidget(),
            
            const SizedBox(height: 32),
            
            // Trending Price Checks
            const TrendingPriceChecks(),
            
            const SizedBox(height: 32),
            
            // Nearby Stores
            const NearbyStoresWidget(),
            
            const SizedBox(height: 32),
            
            // Quick Categories
            const QuickCategoriesWidget(),
            
            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentNavItem,
        onTap: (item) {
          setState(() {
            _currentNavItem = item;
          });
          _handleNavigation(item);
        },
      ),
    );
  }

  void _handleNavigation(NavBarItem item) {
    switch (item) {
      case NavBarItem.home:
        // Already on home, maybe scroll to top
        break;
      case NavBarItem.search:
        context.go('/search');
        break;
      case NavBarItem.addPrice:
        context.go('/add-price');
        break;
      case NavBarItem.alerts:
        context.go('/notifications');
        break;
      case NavBarItem.profile:
        context.go('/profile');
        break;
    }
  }
}