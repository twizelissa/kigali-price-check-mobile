import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/sample_electronics.dart';
import '../../../../core/widgets/custom_bottom_navigation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  NavBarItem _currentNavItem = NavBarItem.search;
  String _selectedCategory = 'All';
  String _selectedPriceRange = 'All';
  String _selectedStore = 'All';

  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(SampleElectronics.products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Search Electronics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Header
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Search Field
                TextField(
                  controller: _searchController,
                  onChanged: _filterProducts,
                  decoration: InputDecoration(
                    hintText: AppStrings.searchPlaceholder,
                    prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Location', Icons.location_on),
                      const SizedBox(width: 8),
                      _buildFilterChip('Price Range', Icons.monetization_on),
                      const SizedBox(width: 8),
                      _buildFilterChip('Store', Icons.store),
                      const SizedBox(width: 8),
                      _buildFilterChip('Category', Icons.category),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Product List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
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

  Widget _buildFilterChip(String label, IconData icon) {
    return GestureDetector(
      onTap: () => _showFilterDialog(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        context.go('/product-details/${product['name']}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getProductIcon(product['category']),
                size: 32,
                color: AppColors.primary,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                 Text(
                   '${product['brand']} • ${product['category']}',
                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                     color: AppColors.textSecondary,
                   ),
                 ),
                 const SizedBox(height: 8),
                 Row(
                   children: [
                     Text(
                       'Avg. Price: ',
                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
                         color: AppColors.textSecondary,
                       ),
                     ),
                     Text(
                       '${_formatPrice(product['averagePrice'])} RWF',
                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                         fontWeight: FontWeight.bold,
                         color: AppColors.primary,
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
           
           // Arrow Icon
           const Icon(
             Icons.arrow_forward_ios,
             size: 16,
             color: AppColors.textSecondary,
           ),
         ],
       ),
     ),
   );
 }

 IconData _getProductIcon(String category) {
   switch (category.toLowerCase()) {
     case 'smartphones':
       return Icons.smartphone;
     case 'laptops':
       return Icons.laptop;
     case 'tablets':
       return Icons.tablet;
     case 'accessories':
       return Icons.headphones;
     default:
       return Icons.devices;
   }
 }

 String _formatPrice(double price) {
   return price.toStringAsFixed(0).replaceAllMapped(
     RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
     (Match m) => '${m[1]},',
   );
 }

 void _filterProducts(String query) {
   setState(() {
     _filteredProducts = SampleElectronics.products.where((product) {
       return product['name'].toLowerCase().contains(query.toLowerCase()) ||
              product['brand'].toLowerCase().contains(query.toLowerCase()) ||
              product['category'].toLowerCase().contains(query.toLowerCase());
     }).toList();
   });
 }

 void _showFilterDialog(String filterType) {
   showModalBottomSheet(
     context: context,
     builder: (context) => Container(
       padding: const EdgeInsets.all(20),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(
             'Filter by $filterType',
             style: Theme.of(context).textTheme.titleLarge?.copyWith(
               fontWeight: FontWeight.bold,
             ),
           ),
           const SizedBox(height: 20),
           ...._getFilterOptions(filterType).map((option) => 
             ListTile(
               title: Text(option),
               onTap: () {
                 Navigator.pop(context);
                 // Apply filter logic here
               },
             ),
           ),
         ],
       ),
     ),
   );
 }

 List<String> _getFilterOptions(String filterType) {
   switch (filterType) {
     case 'Category':
       return ['All', 'Smartphones', 'Laptops', 'Tablets', 'Accessories'];
     case 'Price Range':
       return ['All', 'Under 100K', '100K - 500K', '500K - 1M', 'Over 1M'];
     case 'Store':
       return ['All', 'MTN Telecom', 'Simba Telecom', 'Tech City', 'Computer Village'];
     case 'Location':
       return ['All', 'Kigali City', 'Kimisagara', 'Nyabugogo', 'Remera'];
     default:
       return ['All'];
   }
 }

 void _handleNavigation(NavBarItem item) {
   switch (item) {
     case NavBarItem.home:
       context.go('/home');
       break;
     case NavBarItem.search:
       // Already on search
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

 @override
 void dispose() {
   _searchController.dispose();
   super.dispose();
 }
}
