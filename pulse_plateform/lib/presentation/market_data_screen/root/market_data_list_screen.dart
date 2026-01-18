import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_plateform/core/common/core_app_colors.dart';
import 'package:pulse_plateform/core/common/market_data_constant.dart';
import 'package:pulse_plateform/presentation/market_data_screen/root/provider/market_data_api_provider.dart';
import 'package:pulse_plateform/presentation/market_data_screen/root/provider/market_data_provider.dart';
import 'package:pulse_plateform/resources/dimens.dart';
import 'package:pulse_plateform/widget/animated_loading_indicator.dart';

import 'package:pulse_plateform/widget/empty_state_widget.dart';
import 'package:pulse_plateform/widget/market_data_card.dart';
import 'package:pulse_plateform/widget/market_data_textview.dart';

class MarketDataListScreen extends ConsumerStatefulWidget {
  const MarketDataListScreen({super.key});

  @override
  ConsumerState<MarketDataListScreen> createState() => _MarketDataListScreenState();
}

class _MarketDataListScreenState extends ConsumerState<MarketDataListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _sortBy =
      'rank'; // Options: rank, price, change, symbol, volume, marketCap
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    // Delay the API call to avoid modifying providers during build
    Future.microtask(() {
      ref.read(marketDataProvider).fetchMarketData(ref, context);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<dynamic> _getFilteredAndSortedData(List<dynamic>? data) {
    if (data == null || data.isEmpty) return [];

    // Filter by search query
    var filteredData = data.where((crypto) {
      if (_searchQuery.isEmpty) return true;

      final query = _searchQuery.toLowerCase();
      final name = crypto.name?.toLowerCase() ?? '';
      final symbol = crypto.symbol?.toLowerCase() ?? '';
      final id = crypto.id?.toLowerCase() ?? '';

      return name.contains(query) ||
          symbol.contains(query) ||
          id.contains(query);
    }).toList();

    // Sort data
    filteredData.sort((a, b) {
      int comparison = 0;

      switch (_sortBy) {
        case 'price':
          final priceA = a.currentPrice ?? 0.0;
          final priceB = b.currentPrice ?? 0.0;
          comparison = priceA.compareTo(priceB);
          break;
        case 'change':
          final changeA = a.priceChangePercentage24h ?? 0.0;
          final changeB = b.priceChangePercentage24h ?? 0.0;
          comparison = changeA.compareTo(changeB);
          break;
        case 'symbol':
          final symbolA = a.symbol?.toLowerCase() ?? '';
          final symbolB = b.symbol?.toLowerCase() ?? '';
          comparison = symbolA.compareTo(symbolB);
          break;
        case 'volume':
          final volumeA = a.totalVolume ?? 0.0;
          final volumeB = b.totalVolume ?? 0.0;
          comparison = volumeA.compareTo(volumeB);
          break;
        case 'marketCap':
          final marketCapA = a.marketCap ?? 0.0;
          final marketCapB = b.marketCap ?? 0.0;
          comparison = marketCapA.compareTo(marketCapB);
          break;
        case 'rank':
        default:
          final rankA = a.marketCapRank ?? 999999;
          final rankB = b.marketCapRank ?? 999999;
          comparison = rankA.compareTo(rankB);
          break;
      }

      return _sortAscending ? comparison : -comparison;
    });

    return filteredData;
  }

  @override
  Widget build(BuildContext context) {
    final apiState = ref.watch(marketDataNotifierProvider);

    return Scaffold(
      backgroundColor: CoreAppColors.background,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: MarketDataTextView(MarketDataConstant.cryptoMarket),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: CoreAppColors.backgroundGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: CoreAppColors.backgroundGradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: CoreAppColors.cardShadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(dimen16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: MarketDataConstant.searchHint,
                    prefixIcon:
                        Icon(Icons.search, color: CoreAppColors.primary),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon:
                                Icon(Icons.clear, color: CoreAppColors.grey600),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: CoreAppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: CoreAppColors.borderLight),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: CoreAppColors.borderLight),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: CoreAppColors.primary, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: dimen16,
                      vertical: dimen12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: dimen12),
                // Sort Options
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSortChip(
                          MarketDataConstant.sortByRank, 'rank', Icons.trending_up),
                      const SizedBox(width: dimen8),
                      _buildSortChip(MarketDataConstant.sortByPrice, 'price',
                          Icons.attach_money),
                      const SizedBox(width: dimen8),
                      _buildSortChip(MarketDataConstant.sortByChange, 'change',
                          Icons.show_chart),
                      const SizedBox(width: dimen8),
                      _buildSortChip(MarketDataConstant.sortBySymbol, 'symbol',
                          Icons.sort_by_alpha),
                      const SizedBox(width: dimen8),
                      _buildSortChip(MarketDataConstant.sortByVolume, 'volume',
                          Icons.bar_chart),
                      const SizedBox(width: dimen8),
                      _buildSortChip(MarketDataConstant.sortByMarketCap,
                          'marketCap', Icons.account_balance),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // List Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CoreAppColors.background,
                    CoreAppColors.white,
                    CoreAppColors.background,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
              child: RefreshIndicator(
                color: CoreAppColors.primary,
                backgroundColor: CoreAppColors.white,
                onRefresh: () async {
                  await ref
                      .read(marketDataProvider)
                      .fetchMarketData(ref, context);
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Builder(
                    key: ValueKey<String>(
                      apiState.isLoading
                          ? 'loading'
                          : apiState.error != null
                              ? 'error'
                              : apiState.data != null &&
                                      apiState.data!.isNotEmpty
                                  ? 'data'
                                  : 'empty',
                    ),
                    builder: (context) {
                      // Loading state
                      if (apiState.isLoading) {
                        return const AnimatedLoadingIndicator(
                          message: MarketDataConstant.loadingCryptocurrencies,
                          size: 80.0,
                        );
                      }

                      // Error state
                      if (apiState.error != null) {
                        return EmptyStateWidget(
                          icon: Icons.error_outline,
                          title: MarketDataConstant.error,
                          message: apiState.error?.message ??
                              MarketDataConstant.defaultError,
                          actionButtonText: MarketDataConstant.retry,
                          onActionPressed: () {
                            ref
                                .read(marketDataProvider)
                                .fetchMarketData(ref, context);
                          },
                          iconColor: CoreAppColors.error,
                        );
                      }

                      // Success state with data
                      if (apiState.data != null && apiState.data!.isNotEmpty) {
                        final filteredData =
                            _getFilteredAndSortedData(apiState.data);

                        if (filteredData.isEmpty) {
                          // No results from search
                          return EmptyStateWidget(
                            icon: Icons.search_off,
                            title: MarketDataConstant.noResultsFound,
                            message:
                                '${MarketDataConstant.noSearchResults} "$_searchQuery"',
                            actionButtonText: MarketDataConstant.clearSearch,
                            onActionPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                            iconColor: CoreAppColors.info,
                          );
                        }

                        return ListView.builder(
                          key: const PageStorageKey<String>('crypto_list'),
                          padding: const EdgeInsets.all(dimen16),
                          itemCount: filteredData.length,
                          physics: const ClampingScrollPhysics(),
                          // Better performance on Android
                          // Performance optimizations
                          cacheExtent: 500,
                          // Cache more items for smoother scrolling
                          addAutomaticKeepAlives: false,
                          // Don't keep alive off-screen items
                          addRepaintBoundaries: true,
                          // Add repaint boundaries for better performance
                          itemBuilder: (context, index) {
                            // Only animate first 10 items to prevent performance issues
                            final animationDelay = index < 10
                                ? Duration(milliseconds: 50 * index)
                                : Duration.zero;
                            // Wrap in SizedBox with fixed height for consistent rendering performance
                            return SizedBox(
                              height: cryptoCardTotalHeightWithInfo,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: index < filteredData.length - 1
                                      ? dimen12
                                      : 0,
                                ),
                                child: MarketDataCard(
                                  key: ValueKey(filteredData[index].id),
                                  response: filteredData[index],
                                  animationDelay: animationDelay,
                                  showAdditionalInfo:
                                      true, // Show volume and market cap
                                ),
                              ),
                            );
                          },
                        );
                      }

                      // No data state
                      return EmptyStateWidget(
                        icon: Icons.currency_bitcoin,
                        title: MarketDataConstant.noCryptoDataTitle,
                        message: MarketDataConstant.noCryptoDataMessage,
                        actionButtonText: MarketDataConstant.retry,
                        onActionPressed: () {
                          ref
                              .read(marketDataProvider)
                              .fetchMarketData(ref, context);
                        },
                        iconColor: CoreAppColors.info,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, String sortKey, IconData icon) {
    final isSelected = _sortBy == sortKey;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_sortBy == sortKey) {
            _sortAscending = !_sortAscending;
          } else {
            _sortBy = sortKey;
            _sortAscending = true;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: dimen12, vertical: dimen8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(colors: CoreAppColors.primaryGradient)
              : null,
          color: isSelected ? null : CoreAppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : CoreAppColors.borderMedium,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: CoreAppColors.primaryShadow,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: dimen16,
              color: isSelected ? CoreAppColors.white : CoreAppColors.grey600,
            ),
            const SizedBox(width: dimen4),
            MarketDataTextView(
              label,
              style: TextStyle(
                color: isSelected ? CoreAppColors.white : CoreAppColors.grey600,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: dimen4),
              Icon(
                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
                color: CoreAppColors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
