import 'package:flutter/material.dart';
import 'package:pulse_plateform/resources/dimens.dart';
import 'package:pulse_plateform/widget/market_data_textview.dart';

/// Animated loading indicator with pulsing circles
class AnimatedLoadingIndicator extends StatefulWidget {
  final Color? color;
  final double size;
  final String? message;

  const AnimatedLoadingIndicator({
    super.key,
    this.color,
    this.size = dimen50,
    this.message,
  });

  @override
  State<AnimatedLoadingIndicator> createState() =>
      _AnimatedLoadingIndicatorState();
}

class _AnimatedLoadingIndicatorState extends State<AnimatedLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _LoadingPainter(
                    animation: _controller.value,
                    color: widget.color ?? Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
          ),
          if (widget.message != null) ...[
            const SizedBox(height: dimen16),
            FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              ),
              child: MarketDataTextView(
                widget.message!,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: dimen14,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LoadingPainter extends CustomPainter {
  final double animation;
  final Color color;

  _LoadingPainter({
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw three pulsing circles
    for (int i = 0; i < 3; i++) {
      final delay = i * 0.33;
      final value = (animation + delay) % 1.0;
      final opacity = (1.0 - value) * 0.8;
      final circleRadius = radius * value;

      paint.color = color.withOpacity(opacity);
      canvas.drawCircle(center, circleRadius, paint);
    }

    // Draw center dot
    paint.color = color;
    canvas.drawCircle(center, radius * 0.15, paint);
  }

  @override
  bool shouldRepaint(_LoadingPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

/// Shimmer loading effect for skeleton screens
class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    super.key,
    required this.child,
    this.isLoading = true,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    final baseColor = widget.baseColor ?? Colors.grey[300]!;
    final highlightColor = widget.highlightColor ?? Colors.grey[100]!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                0.0,
                0.5,
                1.0,
              ],
              transform: _SlidingGradientTransform(slidePercent: _animation.value),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

