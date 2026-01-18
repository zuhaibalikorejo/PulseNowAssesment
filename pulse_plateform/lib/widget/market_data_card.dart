import 'package:flutter/material.dart';
import 'package:pulse_plateform/core/common/animated_page_route.dart';
import 'package:pulse_plateform/core/common/core_app_colors.dart';
import 'package:pulse_plateform/core/common/currency_formatter.dart';
import 'package:pulse_plateform/domain/model/response/market_data_response.dart';
import 'package:pulse_plateform/presentation/market_data_screen/detail/market_data_detail_screen.dart';
import 'package:pulse_plateform/resources/dimens.dart';
import 'package:pulse_plateform/widget/market_data_textview.dart';

class MarketDataCard extends StatefulWidget {
  const MarketDataCard({
    super.key,
    required this.response,
    this.animationDelay = Duration.zero,
    this.showAdditionalInfo = false,
  });

  final MarketDataResponse response;
  final Duration animationDelay;
  final bool showAdditionalInfo;

  @override
  State<MarketDataCard> createState() => _MarketDataCardState();
}

class _MarketDataCardState extends State<MarketDataCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animation with delay
    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = (widget.response.priceChangePercentage24h ?? 0) >= 0;

    return RepaintBoundary(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: GestureDetector(
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              onTap: () {
                // Navigate to detail screen with animation
                Navigator.push(
                  context,
                  AnimatedPageRoute(
                    page: MarketDataDetailScreen(cryptoData: widget.response),
                    transitionType: PageTransitionType.fadeScale,
                    duration: const Duration(milliseconds: 400),
                  ),
                );
              },
            child: AnimatedScale(
              scale: _isPressed ? 0.95 : 1.0,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              child: Container(
                padding: const EdgeInsets.all(dimen16),
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
                  border: Border.all(
                    color: CoreAppColors.borderLight,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isPressed
                          ? CoreAppColors.primary.withAlpha(38)  // ~0.15 opacity
                          : CoreAppColors.primaryShadow,
                      blurRadius: _isPressed ? dimen16 : dimen12,
                      offset: Offset(0, _isPressed ? dimen5 : dimen4),
                      spreadRadius: _isPressed ? 1 : 0,
                    ),
                    BoxShadow(
                      color: CoreAppColors.cardShadow,
                      blurRadius: dimen10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Animated Avatar with gradient border
                    Hero(
                      tag: 'crypto_${widget.response.id}',
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: CoreAppColors.primaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(dimen22 + 3),
                        ),
                        child: CircleAvatar(
                          radius: dimen22,
                          backgroundColor: CoreAppColors.white,
                          child: widget.response.image != null
                              ? ClipOval(
                                  child: Image.network(
                                    widget.response.image!,
                                    width: dimen22 * 2,
                                    height: dimen22 * 2,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.currency_bitcoin),
                                  ),
                                )
                              : const Icon(Icons.currency_bitcoin),
                        ),
                      ),
                    ),
                    const SizedBox(width: dimen12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarketDataTextView(
                            widget.response.name ?? "",
                            style: const TextStyle(
                                fontSize: dimen16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: dimen4),
                          MarketDataTextView(
                            widget.response.symbol?.toUpperCase() ?? "",
                            style: TextStyle(color: CoreAppColors.grey500),
                          ),
                          if (widget.showAdditionalInfo) ...[
                            const SizedBox(height: dimen8),
                            Row(
                              children: [
                                Icon(Icons.bar_chart, size: 12, color: CoreAppColors.grey600),
                                const SizedBox(width: dimen4),
                                Expanded(
                                  child: MarketDataTextView(
                                    'Vol: ${CurrencyFormatter.formatLargeNumber(widget.response.totalVolume)}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: CoreAppColors.grey600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: dimen4),
                            Row(
                              children: [
                                Icon(Icons.account_balance, size: 12, color: CoreAppColors.grey600),
                                const SizedBox(width: dimen4),
                                Expanded(
                                  child: MarketDataTextView(
                                    'MCap: ${CurrencyFormatter.formatLargeNumber(widget.response.marketCap)}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: CoreAppColors.grey600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: dimen10),
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CoreAppColors.textPrimary,
                            ),
                            child: MarketDataTextView(
                              CurrencyFormatter.formatCryptoPrice(
                                  widget.response.currentPrice),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // Percentage badge with modern pill design
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: dimen10,
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
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
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
                              // Animated trending icon
                              TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 500),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: 0.8 + (value * 0.2),
                                    child: Icon(
                                      isPositive
                                          ? Icons.trending_up_rounded
                                          : Icons.trending_down_rounded,
                                      color: isPositive
                                          ? CoreAppColors.success
                                          : CoreAppColors.error,
                                      size: 16,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 4),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: TextStyle(
                                  color: isPositive
                                      ? CoreAppColors.success
                                      : CoreAppColors.error,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                                child: Text(
                                  CurrencyFormatter.formatPercentage(
                                      widget.response.priceChangePercentage24h),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}