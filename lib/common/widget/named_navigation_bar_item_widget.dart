import 'package:flutter/widgets.dart';

/// A custom widget for a named navigation bar item.
///
/// [initialLocation] specifies the initial route or location this item represents.
class NamedNavigationBarItemWidget extends BottomNavigationBarItem {
  /// The initial route or location that the navigation bar item represents.
  final String initialLocation;

  /// Creates a [NamedNavigationBarItemWidget].
  ///
  /// Requires [initialLocation] to specify the initial route or location,
  /// and an [icon] to represent the item visually.
  /// An optional [label] can be provided for textual representation.
  NamedNavigationBarItemWidget({
    required this.initialLocation,
    required super.icon,
    super.label,
  });
}
