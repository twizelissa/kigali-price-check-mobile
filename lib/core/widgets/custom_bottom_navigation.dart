import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum NavBarItem { home, search, addPrice, alerts, profile }

class CustomBottomNavigation extends StatelessWidget {
  final NavBarItem currentIndex;
  final Function(NavBarItem) onTap;

  const CustomBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                NavBarItem.home,
                Icons.home_outlined,
                Icons.home,
                'Home',
              ),
              _buildNavItem(
                NavBarItem.search,
                Icons.search_outlined,
                Icons.search,
                'Search',
              ),
              _buildNavItem(
                NavBarItem.addPrice,
                Icons.add_circle_outline,
                Icons.add_circle,
                'Add Price',
              ),
              _buildNavItem(
                NavBarItem.alerts,
                Icons.notifications_outlined,
                Icons.notifications,
                'Alerts',
              ),
              _buildNavItem(
                NavBarItem.profile,
                Icons.person_outline,
                Icons.person,
                'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    NavBarItem item,
    IconData outlinedIcon,
    IconData filledIcon,
    String label,
  ) {
    final isSelected = currentIndex == item;
    
    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? filledIcon : outlinedIcon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}