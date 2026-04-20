import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for customizing badge widget appearance across different styles.
///
/// This class defines the visual properties that can be applied to various
/// badge types including [PrimaryBadge], [SecondaryBadge], [OutlineBadge],
/// and [DestructiveBadge]. Each badge style can have its own button styling
/// configuration to provide consistent appearance across the application.
class BadgeTheme extends ComponentThemeData {
  /// Style for [PrimaryBadge].
  final AbstractButtonStyle? primaryStyle;

  /// Style for [SecondaryBadge].
  final AbstractButtonStyle? secondaryStyle;

  /// Style for [OutlineBadge].
  final AbstractButtonStyle? outlineStyle;

  /// Style for [DestructiveBadge].
  final AbstractButtonStyle? destructiveStyle;

  /// Creates a [BadgeTheme].
  const BadgeTheme({
    this.primaryStyle,
    this.secondaryStyle,
    this.outlineStyle,
    this.destructiveStyle,
  });

  /// Returns a copy of this theme with the given fields replaced.
  BadgeTheme copyWith({
    ValueGetter<AbstractButtonStyle?>? primaryStyle,
    ValueGetter<AbstractButtonStyle?>? secondaryStyle,
    ValueGetter<AbstractButtonStyle?>? outlineStyle,
    ValueGetter<AbstractButtonStyle?>? destructiveStyle,
  }) {
    return BadgeTheme(
      primaryStyle: primaryStyle == null ? this.primaryStyle : primaryStyle(),
      secondaryStyle:
          secondaryStyle == null ? this.secondaryStyle : secondaryStyle(),
      outlineStyle: outlineStyle == null ? this.outlineStyle : outlineStyle(),
      destructiveStyle:
          destructiveStyle == null ? this.destructiveStyle : destructiveStyle(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BadgeTheme &&
        other.primaryStyle == primaryStyle &&
        other.secondaryStyle == secondaryStyle &&
        other.outlineStyle == outlineStyle &&
        other.destructiveStyle == destructiveStyle;
  }

  @override
  int get hashCode =>
      Object.hash(primaryStyle, secondaryStyle, outlineStyle, destructiveStyle);
}

AbstractButtonStyle _badgeBaseStyle(AbstractButtonStyle style) {
  return style.copyWith(
    textStyle: (context, states, value) {
      return value.copyWith(fontWeight: FontWeight.w500);
    },
  );
}

AbstractButtonStyle _badgeStaticStyle(AbstractButtonStyle style) {
  return style.copyWith(
    decoration: (context, states, decoration) {
      final effectiveStates = Set<WidgetState>.of(states)
        ..remove(WidgetState.disabled);
      return style.decoration(context, effectiveStates);
    },
    mouseCursor: (context, states, mouseCursor) {
      return SystemMouseCursors.basic;
    },
    textStyle: (context, states, value) {
      final effectiveStates = Set<WidgetState>.of(states)
        ..remove(WidgetState.disabled);
      return style.textStyle(context, effectiveStates);
    },
    iconTheme: (context, states, value) {
      final effectiveStates = Set<WidgetState>.of(states)
        ..remove(WidgetState.disabled);
      return style.iconTheme(context, effectiveStates);
    },
  );
}

Color _badgeColorTone(Color color, double delta) {
  final hsl = HSLColor.fromColor(color);
  return hsl.withLightness((hsl.lightness + delta).clamp(0.0, 1.0)).toColor();
}

Color _resolveCustomBadgeColor(Color color, Set<WidgetState> states) {
  if (states.contains(WidgetState.disabled)) {
    return color.scaleAlpha(0.55);
  }

  final delta = color.computeLuminance() > 0.45 ? -1.0 : 1.0;
  if (states.contains(WidgetState.pressed)) {
    return _badgeColorTone(color, 0.08 * delta);
  }
  if (states.contains(WidgetState.hovered) ||
      states.contains(WidgetState.focused)) {
    return _badgeColorTone(color, 0.04 * delta);
  }
  return color;
}

Decoration _resolveCustomBadgeDecoration(
  BuildContext context,
  Set<WidgetState> states,
  Decoration decoration,
  Color color,
) {
  final resolvedColor = _resolveCustomBadgeColor(color, states);
  if (decoration is BoxDecoration) {
    return BoxDecoration(
      color: resolvedColor,
      image: decoration.image,
      border: decoration.border,
      borderRadius:
          decoration.shape == BoxShape.circle ? null : decoration.borderRadius,
      boxShadow: decoration.boxShadow,
      shape: decoration.shape,
      backgroundBlendMode: decoration.backgroundBlendMode,
    );
  }
  if (decoration is ShapeDecoration) {
    return ShapeDecoration(
      color: resolvedColor,
      image: decoration.image,
      shadows: decoration.shadows,
      shape: decoration.shape,
    );
  }

  final theme = Theme.of(context);
  return BoxDecoration(
    color: resolvedColor,
    borderRadius: BorderRadius.circular(theme.radiusMd),
  );
}

class _Badge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle style;

  const _Badge({
    required this.child,
    required this.style,
    this.onPressed,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final interactive = onPressed != null;
    final resolvedStyle = interactive ? style : _badgeStaticStyle(style);
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: interactive,
        style: resolvedStyle,
        child: child,
      ),
    );
  }
}

/// A primary style badge widget for highlighting important information or status.
///
/// [PrimaryBadge] displays content in a prominent badge format using the primary
/// color scheme. It's designed for high-importance status indicators, labels,
/// and interactive elements that need to draw attention. The badge supports
/// leading and trailing widgets for icons or additional content.
///
/// Key features:
/// - Primary color styling with emphasis and contrast
/// - Optional tap handling for interactive badges
/// - Support for leading and trailing widgets (icons, counters, etc.)
/// - Customizable button styling through theme integration
/// - Compact size optimized for badge display
/// - Consistent visual hierarchy with other badge variants
///
/// The badge uses button-like styling but in a compact form factor suitable
/// for status displays, labels, and small interactive elements. It integrates
/// with the theme system to maintain visual consistency.
///
/// Common use cases:
/// - Status indicators (active, new, featured)
/// - Notification counts and alerts
/// - Category labels and tags
/// - Interactive filter chips
/// - Achievement or ranking displays
///
/// Example:
/// ```dart
/// PrimaryBadge(
///   child: Text('NEW'),
///   leading: Icon(Icons.star, size: 16),
///   onPressed: () => _showNewItems(),
/// );
///
/// // Non-interactive status badge
/// PrimaryBadge(
///   child: Text('5'),
///   trailing: Icon(Icons.notifications, size: 14),
/// );
/// ```
class PrimaryBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed, making it interactive.
  ///
  /// If `null`, the badge is non-interactive.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  ///
  /// If `null`, uses theme's primary badge style or default primary styling.
  final AbstractButtonStyle? style;

  /// Creates a primary badge.
  const PrimaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = _badgeBaseStyle(
      style ??
          compTheme?.primaryStyle ??
          const ButtonStyle.primary(
            size: ButtonSize.small,
            density: ButtonDensity.dense,
            shape: ButtonShape.rectangle,
          ),
    );
    return _Badge(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      style: baseStyle,
      child: child,
    );
  }
}

/// A badge with manually specified colors.
///
/// [CustomBadge] keeps the compact badge layout while allowing the fill color
/// to be set directly. When [foregroundColor] is omitted, a contrasting label
/// color is derived automatically from [color].
///
/// Example:
/// ```dart
/// CustomBadge(
///   color: Colors.emerald,
///   child: Text('BETA'),
/// );
///
/// CustomBadge(
///   color: Colors.orange,
///   foregroundColor: Colors.black,
///   leading: Icon(Icons.warning_amber_rounded, size: 14),
///   child: Text('Needs Review'),
/// );
/// ```
class CustomBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// The badge fill color.
  final Color color;

  /// Optional explicit foreground color for text and icons.
  ///
  /// If `null`, a contrasting color is derived from [color].
  final Color? foregroundColor;

  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional style override used as the structural base for the badge.
  ///
  /// The supplied style keeps its padding, margin, and shape, while the badge
  /// color and foreground are resolved from [color] and [foregroundColor].
  final AbstractButtonStyle? style;

  /// Creates a badge with manually specified colors.
  const CustomBadge({
    super.key,
    required this.child,
    required this.color,
    this.foregroundColor,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedForegroundColor = foregroundColor ?? color.getContrastColor();
    final baseStyle = _badgeBaseStyle(
      (style ??
              const ButtonStyle.primary(
                size: ButtonSize.small,
                density: ButtonDensity.dense,
                shape: ButtonShape.rectangle,
              ))
          .copyWith(
        decoration: (context, states, decoration) {
          return _resolveCustomBadgeDecoration(
            context,
            states,
            decoration,
            color,
          );
        },
        textStyle: (context, states, value) {
          return value.copyWith(
            color: states.contains(WidgetState.disabled)
                ? resolvedForegroundColor.scaleAlpha(0.7)
                : resolvedForegroundColor,
          );
        },
        iconTheme: (context, states, value) {
          return value.copyWith(
            color: states.contains(WidgetState.disabled)
                ? resolvedForegroundColor.scaleAlpha(0.7)
                : resolvedForegroundColor,
          );
        },
      ),
    );
    return _Badge(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      style: baseStyle,
      child: child,
    );
  }
}

/// A secondary-styled badge for displaying labels, counts, or status indicators.
///
/// Similar to [PrimaryBadge] but with secondary (muted) styling suitable for
/// less prominent information.
class SecondaryBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  final AbstractButtonStyle? style;

  /// Creates a secondary badge with the specified child content.
  const SecondaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = _badgeBaseStyle(
      style ??
          compTheme?.secondaryStyle ??
          const ButtonStyle.secondary(
            size: ButtonSize.small,
            density: ButtonDensity.dense,
            shape: ButtonShape.rectangle,
          ),
    );
    return _Badge(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      style: baseStyle,
      child: child,
    );
  }
}

/// An outline-styled badge for displaying labels, counts, or status indicators.
///
/// Uses outline styling with a visible border and no background fill,
/// suitable for less visually prominent badge elements.
class OutlineBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  final AbstractButtonStyle? style;

  /// Creates an outline badge with the specified child content.
  const OutlineBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = _badgeBaseStyle(
      style ??
          compTheme?.outlineStyle ??
          const ButtonStyle.outline(
            size: ButtonSize.small,
            density: ButtonDensity.dense,
            shape: ButtonShape.rectangle,
          ),
    );
    return _Badge(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      style: baseStyle,
      child: child,
    );
  }
}

/// A destructive-styled badge for displaying warnings or dangerous actions.
///
/// Uses destructive (typically red) styling to indicate dangerous, destructive,
/// or critical information that requires user attention.
class DestructiveBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  final AbstractButtonStyle? style;

  /// Creates a destructive badge with the specified child content.
  const DestructiveBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = _badgeBaseStyle(
      style ??
          compTheme?.destructiveStyle ??
          const ButtonStyle.destructive(
            size: ButtonSize.small,
            density: ButtonDensity.dense,
            shape: ButtonShape.rectangle,
          ),
    );
    return _Badge(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      style: baseStyle,
      child: child,
    );
  }
}
