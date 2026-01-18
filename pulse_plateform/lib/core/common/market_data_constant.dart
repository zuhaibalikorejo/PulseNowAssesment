class MarketDataConstant {
  // Private constructor to prevent instantiation
  MarketDataConstant._();

  // App Information
  static const String pulsePlateFarm = "Pulse Platefarm";
  static const String cryptoMarket = "Crypto Market";

  // Error Messages
  static const String systemMaintainanceError = "/registration/device/register";
  static const String technicalError = "A technical error occurred. Please try again later.";
  static const String defaultError = "Something went wrong. Please try again.";
  static const String timeOut = "Request timeout. Please check your connection and try again.";
  static const String error = "Error";

  // Empty State Messages
  static const String noDataAvaiable = "noDataAvaiable"; // Keep for backward compatibility
  static const String noDataAvailable = "No Data Available";
  static const String noRecordFound = "No records found.";
  static const String noCryptoDataTitle = "No Cryptocurrencies Found";
  static const String noCryptoDataMessage = "We couldn't find any cryptocurrency data at the moment. Please try refreshing or check back later.";
  static const String emptyListMessage = "The list is empty. Pull down to refresh and load data.";
  static const String noResultsFound = "No Results Found";
  static const String noSearchResults = "No cryptocurrencies match your search";
  static const String clearSearch = "Clear Search";

  // Search & Filter
  static const String searchHint = "Search by name, symbol, or ID...";
  static const String sortByRank = "Rank";
  static const String sortByPrice = "Price";
  static const String sortByChange = "24h Change";
  static const String sortBySymbol = "Symbol";
  static const String sortByVolume = "Volume";
  static const String sortByMarketCap = "Market Cap";

  // Loading Messages
  static const String loadingCryptocurrencies = "Loading cryptocurrencies...";
  static const String loading = "Loading...";

  // Action Buttons
  static const String retry = "Retry";
  static const String dismiss = "Dismiss";
  static const String ok = "OK";
  static const String cancel = "Cancel";
  static const String refresh = "Refresh";

  // Screen Titles
  static const String cryptoDetails = "Crypto Details";
  static const String basicInformation = "Basic Information";
  static const String marketData = "Market Data";
  static const String supplyInformation = "Supply Information";
  static const String priceInformation = "Price Information";

  // Field Labels - Basic Info
  static const String id = "ID";
  static const String symbol = "Symbol";
  static const String name = "Name";
  static const String currentPrice = "Current Price";
  static const String marketCapRank = "Market Cap Rank";
  static const String lastUpdated = "Last Updated";
  static const String rank = "Rank";

  // Field Labels - Market Data
  static const String marketCap = "Market Cap";
  static const String totalVolume = "Total Volume";
  static const String high24h = "24h High";
  static const String low24h = "24h Low";
  static const String priceChange24h = "24h Price Change";
  static const String priceChangePercentage24h = "24h Change %";

  // Field Labels - ATH/ATL
  static const String allTimeHigh = "ATH (All-Time High)";
  static const String allTimeLow = "ATL (All-Time Low)";
  static const String athDate = "ATH Date";
  static const String atlDate = "ATL Date";
  static const String athChangePercentage = "ATH Change %";
  static const String atlChangePercentage = "ATL Change %";

  // Field Labels - Supply
  static const String circulatingSupply = "Circulating Supply";
  static const String totalSupply = "Total Supply";
  static const String maxSupply = "Max Supply";
  static const String fullyDilutedValuation = "Fully Diluted Valuation";

  // Default Values
  static const String nA = "N/A";
  static const String unlimited = "Unlimited";

  // Format Prefixes
  static const String rankPrefix = "Rank #";

  // Legacy Constants (deprecated)
  @Deprecated('Use high24h instead')
  static const String heigh = "24h High";
  @Deprecated('Use low24h instead')
  static const String low = "24h Low";
  @Deprecated('Use allTimeHigh instead')
  static const String allTimeHeigh = "ATH (All-Time High)";
  @Deprecated('Use atlDate instead')
  static const String altDate = "ATL Date";






















}