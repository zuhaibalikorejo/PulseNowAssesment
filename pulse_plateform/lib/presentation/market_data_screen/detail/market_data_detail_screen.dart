import 'package:flutter/material.dart';
import 'package:pulse_plateform/core/common/core_app_colors.dart';
import 'package:pulse_plateform/core/common/currency_formatter.dart';
import 'package:pulse_plateform/core/common/market_data_constant.dart';
import 'package:pulse_plateform/domain/model/response/market_data_response.dart';
import 'package:pulse_plateform/resources/dimens.dart';
import 'package:pulse_plateform/widget/market_data_textview.dart';

class MarketDataDetailScreen extends StatefulWidget {
  final MarketDataResponse cryptoData;

  const MarketDataDetailScreen({
    super.key,
    required this.cryptoData,
  });

  @override
  State<MarketDataDetailScreen> createState() => _MarketDataDetailScreenState();
}

class _MarketDataDetailScreenState extends State<MarketDataDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = (widget.cryptoData.priceChangePercentage24h ?? 0) >= 0;

    return Scaffold(
      backgroundColor: CoreAppColors.background,
      appBar: AppBar(
        title: MarketDataTextView(widget.cryptoData.name ?? MarketDataConstant.cryptoDetails),
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
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(dimen16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card with Image and Basic Info
                _buildHeaderCard(isPositive),
                const SizedBox(height: dimen16),

                // Price Information Card
                _buildPriceCard(isPositive),
                const SizedBox(height: dimen16),

                // Detailed Information Card
                _buildDetailedInfoCard(),
                const SizedBox(height: dimen16),

                // Market Data Card
                _buildMarketDataCard(),
                const SizedBox(height: dimen16),

                // Supply Information Card
                _buildSupplyInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(bool isPositive) {
    return Container(
      padding: const EdgeInsets.all(dimen24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CoreAppColors.white,
            CoreAppColors.grey50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(dimen16),
        border: Border.all(color: CoreAppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: CoreAppColors.primaryShadow,
            blurRadius: dimen12,
            offset: const Offset(0, dimen4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Crypto Logo
          Hero(
            tag: 'crypto_${widget.cryptoData.id}',
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: CoreAppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(dimen50),
              ),
              child: CircleAvatar(
                radius: dimen40,
                backgroundColor: CoreAppColors.white,
                child: widget.cryptoData.image != null
                    ? ClipOval(
                        child: Image.network(
                          widget.cryptoData.image!,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.currency_bitcoin, size: dimen40),
                        ),
                      )
                    : const Icon(Icons.currency_bitcoin, size: dimen40),
              ),
            ),
          ),
          const SizedBox(height: dimen16),

          // Name and Symbol
          MarketDataTextView(
            widget.cryptoData.name ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            alignment: TextAlign.center,
          ),
          const SizedBox(height: dimen4),
          MarketDataTextView(
            widget.cryptoData.symbol?.toUpperCase() ?? '',
            style: TextStyle(
              fontSize: dimen16,
              color: CoreAppColors.grey600,
            ),
            alignment: TextAlign.center,
          ),
          const SizedBox(height: dimen16),

          // Market Cap Rank Badge
          if (widget.cryptoData.marketCapRank != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: dimen16,
                vertical: dimen8,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: CoreAppColors.primaryGradient,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: MarketDataTextView(
                '${MarketDataConstant.rankPrefix}${widget.cryptoData.marketCapRank}',
                style: const TextStyle(
                  color: CoreAppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(bool isPositive) {
    return Container(
      padding: const EdgeInsets.all(dimen20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CoreAppColors.white,
            CoreAppColors.grey50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(dimen16),
        border: Border.all(color: CoreAppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: CoreAppColors.primaryShadow,
            blurRadius: dimen12,
            offset: const Offset(0, dimen4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarketDataTextView(
            MarketDataConstant.currentPrice,
            style: TextStyle(
              fontSize: dimen14,
              color: CoreAppColors.grey600,
            ),
          ),
          const SizedBox(height: dimen10),
          MarketDataTextView(
            CurrencyFormatter.formatCryptoPrice(widget.cryptoData.currentPrice),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: dimen12),

          // 24h Change
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: dimen12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isPositive
                        ? [
                            CoreAppColors.success.withAlpha(38), // 0.15 opacity
                            CoreAppColors.success.withAlpha(20), // 0.08 opacity
                          ]
                        : [
                            CoreAppColors.error.withAlpha(38), // 0.15 opacity
                            CoreAppColors.error.withAlpha(20), // 0.08 opacity
                          ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isPositive
                        ? CoreAppColors.success.withAlpha(77) // 0.3 opacity
                        : CoreAppColors.error.withAlpha(77), // 0.3 opacity
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      color: isPositive
                          ? CoreAppColors.success
                          : CoreAppColors.error,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    MarketDataTextView(
                      CurrencyFormatter.formatPercentage(
                          widget.cryptoData.priceChangePercentage24h),
                      style: TextStyle(
                        color: isPositive
                            ? CoreAppColors.success
                            : CoreAppColors.error,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: dimen10),
              MarketDataTextView(
                CurrencyFormatter.formatCryptoPrice(
                    widget.cryptoData.priceChange24h),
                style: TextStyle(
                  color: isPositive
                      ? CoreAppColors.success
                      : CoreAppColors.error,
                  fontWeight: FontWeight.w600,
                  fontSize: dimen14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedInfoCard() {
    return Container(
      padding: const EdgeInsets.all(dimen20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CoreAppColors.white,
            CoreAppColors.grey50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(dimen16),
        border: Border.all(color: CoreAppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: CoreAppColors.primaryShadow,
            blurRadius: dimen12,
            offset: const Offset(0, dimen4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarketDataTextView(
            MarketDataConstant.basicInformation,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: dimen16),
          _buildDataRow(MarketDataConstant.id, widget.cryptoData.id),
          _buildDataRow(MarketDataConstant.symbol, widget.cryptoData.symbol?.toUpperCase()),
          _buildDataRow(MarketDataConstant.name, widget.cryptoData.name),
          _buildDataRow(
            MarketDataConstant.currentPrice,
            CurrencyFormatter.formatCryptoPrice(widget.cryptoData.currentPrice),
          ),
          _buildDataRow(
            MarketDataConstant.marketCapRank,
            widget.cryptoData.marketCapRank?.toString(),
          ),
          _buildDataRow(
            MarketDataConstant.lastUpdated,
            widget.cryptoData.lastUpdated ?? MarketDataConstant.nA,
          ),
        ],
      ),
    );
  }

  Widget _buildMarketDataCard() {
    return Container(
      padding: const EdgeInsets.all(dimen20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CoreAppColors.white,
            CoreAppColors.grey50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(dimen16),
        border: Border.all(color: CoreAppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: CoreAppColors.primaryShadow,
            blurRadius: dimen12,
            offset: const Offset(0, dimen4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarketDataTextView(
            MarketDataConstant.marketData,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: dimen16),
          _buildDataRow(
            MarketDataConstant.marketCap,
            CurrencyFormatter.formatLargeNumber(widget.cryptoData.marketCap),
          ),
          _buildDataRow(
            MarketDataConstant.totalVolume,
            CurrencyFormatter.formatLargeNumber(widget.cryptoData.totalVolume),
          ),
          _buildDataRow(
            MarketDataConstant.high24h,
            CurrencyFormatter.formatCryptoPrice(widget.cryptoData.high24h),
          ),
          _buildDataRow(
            MarketDataConstant.low24h,
            CurrencyFormatter.formatCryptoPrice(widget.cryptoData.low24h),
          ),
          _buildDataRow(
            MarketDataConstant.allTimeHigh,
            CurrencyFormatter.formatCryptoPrice(widget.cryptoData.ath),
          ),
          _buildDataRow(MarketDataConstant.athDate, widget.cryptoData.athDate),
          _buildDataRow(
            MarketDataConstant.allTimeLow,
            CurrencyFormatter.formatCryptoPrice(widget.cryptoData.atl),
          ),
          _buildDataRow(MarketDataConstant.atlDate, widget.cryptoData.atlDate),
        ],
      ),
    );
  }

  Widget _buildSupplyInfoCard() {
    return Container(
      padding: const EdgeInsets.all(dimen20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CoreAppColors.white,
            CoreAppColors.grey50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(dimen16),
        border: Border.all(color: CoreAppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: CoreAppColors.primaryShadow,
            blurRadius: dimen12,
            offset: const Offset(0, dimen4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarketDataTextView(
            MarketDataConstant.supplyInformation,
            style: TextStyle(
              fontSize: dimen18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: dimen16),
          _buildDataRow(
            MarketDataConstant.circulatingSupply,
            widget.cryptoData.circulatingSupply != null
                ? '${_formatSupply(widget.cryptoData.circulatingSupply)} ${widget.cryptoData.symbol?.toUpperCase() ?? ''}'
                : MarketDataConstant.nA,
          ),
          _buildDataRow(
            MarketDataConstant.totalSupply,
            widget.cryptoData.totalSupply != null
                ? '${_formatSupply(widget.cryptoData.totalSupply)} ${widget.cryptoData.symbol?.toUpperCase() ?? ''}'
                : MarketDataConstant.nA,
          ),
          _buildDataRow(
            MarketDataConstant.maxSupply,
            widget.cryptoData.maxSupply != null
                ? '${_formatSupply(widget.cryptoData.maxSupply)} ${widget.cryptoData.symbol?.toUpperCase() ?? ''}'
                : MarketDataConstant.nA,
          ),
          _buildDataRow(
            MarketDataConstant.fullyDilutedValuation,
            CurrencyFormatter.formatLargeNumber(
                widget.cryptoData.fullyDilutedValuation),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: dimen12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: MarketDataTextView(
              label,
              style: TextStyle(
                fontSize: dimen14,
                color: CoreAppColors.grey600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: dimen10),
          Expanded(
            flex: 3,
            child: MarketDataTextView(
              value ?? MarketDataConstant.nA,
              style: const TextStyle(
                fontSize: dimen14,
                fontWeight: FontWeight.w600,
                color: CoreAppColors.textPrimary,
              ),
              alignment: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  String _formatSupply(double? number) {
    if (number == null) return MarketDataConstant.nA;
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(2)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    }
    return number.toStringAsFixed(2);
  }
}

