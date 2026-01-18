import 'package:flutter/material.dart';

/// Custom page route transitions for smooth navigation
class AnimatedPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;
  final PageTransitionType transitionType;

  AnimatedPageRoute({
    required this.page,
    this.duration = const Duration(milliseconds: 400),
    this.transitionType = PageTransitionType.slideFromRight,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(
              animation,
              secondaryAnimation,
              child,
              transitionType,
            );
          },
        );

  static Widget _buildTransition(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    PageTransitionType type,
  ) {
    switch (type) {
      case PageTransitionType.fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );

      case PageTransitionType.slideFromRight:
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );

      case PageTransitionType.slideFromLeft:
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );

      case PageTransitionType.slideFromBottom:
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );

      case PageTransitionType.scale:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

      case PageTransitionType.rotation:
        return RotationTransition(
          turns: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

      case PageTransitionType.fadeScale:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
    }
  }
}

enum PageTransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  scale,
  rotation,
  fadeScale,
}

/// Extension method for easy navigation with animations
extension NavigatorAnimation on BuildContext {
  Future<T?> pushWithAnimation<T>(
    Widget page, {
    PageTransitionType type = PageTransitionType.slideFromRight,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return Navigator.push<T>(
      this,
      AnimatedPageRoute<T>(
        page: page,
        transitionType: type,
        duration: duration,
      ),
    );
  }
}

