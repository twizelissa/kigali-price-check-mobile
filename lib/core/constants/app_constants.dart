class AppConstants {
  static const String appName = 'KigaliPriceCheck';
  static const String appVersion = '1.0.0';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String vendorsCollection = 'vendors';
  static const String productsCollection = 'products';
  static const String pricesCollection = 'prices';
  static const String shoppingListsCollection = 'shopping_lists';
  static const String reviewsCollection = 'reviews';
  static const String notificationsCollection = 'notifications';
  static const String priceAlertsCollection = 'price_alerts';
  static const String userFavoritesCollection = 'user_favorites';
  static const String marketAnalyticsCollection = 'market_analytics';
  
  // SharedPreferences Keys
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String notificationsKey = 'notifications_enabled';
  static const String locationKey = 'default_location';
  static const String firstLaunchKey = 'first_launch';
  static const String userTokenKey = 'user_token';
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxReputationScore = 100;
  static const double maxPriceVariance = 0.5;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxSearchResults = 100;
  
  // Rwanda specific
  static const String rwandaCountryCode = '+250';
  static const String defaultCurrency = 'RWF';
  static const String defaultLanguage = 'en';
  
  // API endpoints (for future use)
  static const String baseUrl = 'https://api.kigalipricecheck.rw';
  static const String apiVersion = 'v1';
}