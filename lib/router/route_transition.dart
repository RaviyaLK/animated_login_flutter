part of 'router.dart';

enum SlideTransitionType { rightToLeft, bottomToTop }

class CustomNoTransitionPage<T> extends CustomTransitionPage<T> {
  const CustomNoTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          maintainState: false,
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;
}

Page<dynamic> pageTransition(
    BuildContext context, GoRouterState state, Widget page,
    {SlideTransitionType type = SlideTransitionType.rightToLeft,
    String? restorationId}) {
  final position = switch (type) {
    SlideTransitionType.bottomToTop => Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ),
    _ => Tween<Offset>(
        begin: const Offset(1.5, 0),
        end: Offset.zero,
      ),
  };

  return CustomTransitionPage(
    child: page,
    key: state.pageKey,
    restorationId: restorationId,
    transitionDuration: StaticDurations.pageTransition,
    reverseTransitionDuration: StaticDurations.pageTransition,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: position.animate(animation),
      child: child,
    ),
  );
}

