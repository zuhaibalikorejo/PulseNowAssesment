import 'package:flutter/material.dart';
import 'package:pulse_plateform/core/common/core_app_colors.dart';
import 'package:pulse_plateform/resources/dimens.dart';
import 'package:pulse_plateform/widget/market_data_textview.dart';

/// A reusable empty state widget for displaying when no data is available
class EmptyStateWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionButtonText;
  final VoidCallback? onActionPressed;
  final Color? iconColor;

  const EmptyStateWidget({
    super.key,
    this.icon = Icons.inbox_outlined,
    required this.title,
    required this.message,
    this.actionButtonText,
    this.onActionPressed,
    this.iconColor,
  });

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
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
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(dimen32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Icon with pulsing effect
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 2000),
                    tween: Tween(begin: 1.0, end: 1.1),
                    curve: Curves.easeInOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    onEnd: () {
                      // Loop the pulse animation
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(dimen24),
                      decoration: BoxDecoration(
                        color: (widget.iconColor ?? CoreAppColors.grey500).withAlpha(26), // 0.1 opacity
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        size: dimen60,
                        color: widget.iconColor ?? CoreAppColors.grey500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: dimen24),

                // Animated Title
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: MarketDataTextView(
                    widget.title,
                    style: const TextStyle(
                      fontSize: dimen20,
                      fontWeight: FontWeight.bold,
                      color: CoreAppColors.textPrimary,
                    ),
                    alignment: TextAlign.center,
                  ),
                ),
                const SizedBox(height: dimen12),

                // Animated Message
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: MarketDataTextView(
                    widget.message,
                    style: TextStyle(
                      fontSize: dimen14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                    alignment: TextAlign.center,
                  ),
                ),

                // Animated Action Button (optional)
                if (widget.actionButtonText != null &&
                    widget.onActionPressed != null) ...[
                  const SizedBox(height: dimen24),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: ElevatedButton.icon(
                      onPressed: widget.onActionPressed,
                      icon: const Icon(Icons.refresh),
                      label: MarketDataTextView(widget.actionButtonText!),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: dimen24,
                          vertical: dimen12,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

