import 'package:flutter/material.dart';

import 'animations.dart';

/// Used by [FlatHarpyButton] to build a different icon when the button is
/// highlighted.
///
/// Implemented in [FavoriteButton] to build a [FlareActor] icon with an
/// animation.
typedef IconBuilder = Widget Function(BuildContext context, bool highlighted);

/// A flat button with a transparent background that can consist of either an
/// [icon], a [text] or both.
///
/// The [text] uses the body1 style of the [Theme].
class FlatHarpyButton extends StatefulWidget {
  const FlatHarpyButton({
    this.icon,
    this.iconSize = 18,
    this.iconBuilder,
    this.text,
    this.color,
    this.alwaysColored = true,
    this.onTap,
  }) : assert((icon != null || iconBuilder != null) || text != null);

  /// The [IconData] used in an [Icon] widget.
  final IconData icon;

  /// The size for the [Icon] that is build with the [icon].
  final double iconSize;

  /// The [IconBuilder] can be used to build a different icon when the button
  /// is highlighted.
  ///
  /// Not used if [icon] is not `null`.
  final IconBuilder iconBuilder;

  /// The [text] used in a [Text] widget with the body1 style of the [Theme].
  final String text;

  /// The [Color] of the text and icon.
  ///
  /// Depending on [alwaysColored] the text and icon might only be colored
  /// while the button is highlighted (pressed down).
  ///
  /// Also used with a low opacity for the splashColor of the underlying
  /// [InkWell].
  final Color color;

  /// Determines if the text and icon should always appear in the [color] or
  /// only while the button is highlighted (pressed down).
  final bool alwaysColored;

  /// Called when the button is tapped.
  final GestureTapCallback onTap;

  @override
  FlatHarpyButtonState createState() => FlatHarpyButtonState();
}

class FlatHarpyButtonState extends State<FlatHarpyButton> {
  bool _highlighted = false;

  void _onHighlightChanged(bool highlighted) {
    setState(() {
      _highlighted = highlighted;
    });
  }

  bool get _hasIcon => widget.icon != null || widget.iconBuilder != null;

  /// Gets the color for the icon and text.
  Color get _color =>
      _highlighted || widget.alwaysColored ? widget.color : null;

  /// Builds the icon from the [widget.icon] or [widget.iconBuilder].
  Widget _buildIcon(BuildContext context) {
    if (widget.icon != null) {
      return Icon(widget.icon, size: widget.iconSize, color: _color);
    }

    if (widget.iconBuilder != null) {
      return widget.iconBuilder(context, _highlighted);
    }

    return Container();
  }

  /// Builds the space between the icon and text if both are not `null`.
  Widget _buildSeparator() {
    return _hasIcon && widget.text != null
        ? const SizedBox(width: 8)
        : Container();
  }

  /// Builds the text from the [widget.text].
  Widget _buildText(BuildContext context) {
    if (widget.text == null) {
      return Container();
    }

    return Text(
      widget.text,
      style: Theme.of(context).textTheme.body1.copyWith(color: _color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      highlightColor: Colors.transparent,
      splashColor: widget.color?.withOpacity(0.3),
      onHighlightChanged: _onHighlightChanged,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: <Widget>[
            _buildIcon(context),
            _buildSeparator(),
            _buildText(context),
          ],
        ),
      ),
    );
  }
}

/// Builds on the [FlatHarpyButton] and has a different behavior if the button
/// is [active] or not.
class FlatHarpyActionButton extends StatelessWidget {
  const FlatHarpyActionButton({
    @required this.active,
    this.activeIcon,
    this.inactiveIcon,
    this.iconSize = 18,
    this.text,
    this.color,
    this.activate,
    this.deactivate,
  });

  final bool active;

  /// The icon that is built when [active] is `true`.
  final IconData activeIcon;

  /// The icon that is built when [active] is `false`.
  final IconData inactiveIcon;

  /// See [FlatHarpyButton].
  final double iconSize;

  /// See [FlatHarpyButton].
  final String text;

  /// See [FlatHarpyButton].
  final Color color;

  /// The callback when the button is pressed and [active] is `false`.
  final VoidCallback activate;

  /// The callback when the button is pressed and [active] is `true`.
  final VoidCallback deactivate;

  @override
  Widget build(BuildContext context) {
    return FlatHarpyButton(
      icon: active ? activeIcon : inactiveIcon,
      iconSize: iconSize,
      text: text,
      color: color,
      alwaysColored: active,
      onTap: active ? deactivate : activate,
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    @required this.child,
    this.backgroundColor = Colors.black26,
    this.highlightColor = Colors.white10,
    this.splashColor = Colors.white24,
    this.padding = const EdgeInsets.all(8),
    this.onPressed,
  });

  final Widget child;
  final Color backgroundColor;
  final Color highlightColor;
  final Color splashColor;
  final EdgeInsets padding;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor,
        child: InkWell(
          highlightColor: highlightColor,
          splashColor: splashColor,
          onTap: onPressed,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// The base of the harpy button used by the raised and flat harpy button.
class _HarpyButtonBase extends StatefulWidget {
  const _HarpyButtonBase({
    @required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  _HarpyButtonBaseState createState() => _HarpyButtonBaseState();
}

class _HarpyButtonBaseState extends State<_HarpyButtonBase> {
  bool _tapDown = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _tapDown ? .9 : 1,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _tapDown = true),
        onTapUp: (_) => setState(() => _tapDown = false),
        onTapCancel: () => setState(() => _tapDown = false),
        onTap: widget.onTap,
        child: widget.child,
      ),
    );
  }
}

class BounceInRaisedButton extends StatelessWidget {
  final Widget title;
  final Duration duration;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color titleColor;
  final double borderRadius;

  const BounceInRaisedButton(
      {Key key,
      @required this.title,
      this.duration,
      @required this.onPressed,
      this.backgroundColor,
      this.titleColor,
      this.borderRadius})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BounceInAnimation(
      duration: duration,
      child: RaisedButton(
        onPressed: onPressed,
        child: title,
      ),
    );
  }
}

/// A raised button with a background.
class RaisedHarpyButton extends StatelessWidget {
  const RaisedHarpyButton({
    @required this.title,
    @required this.onPressed,
    this.dense = false,
    this.backgroundColor,
  });

  final String title;
  final VoidCallback onPressed;
  final bool dense;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(64);
    final padding = EdgeInsets.symmetric(
      vertical: dense ? 8 : 12,
      horizontal: dense ? 16 : 32,
    );

    // final theme = ThemeSettingsModel.of(context).harpyTheme.theme;
    final theme = ThemeData.dark();

    final color = backgroundColor ?? theme.buttonColor;
    final style = backgroundColor != null
        ? theme.textTheme.button.copyWith(color: theme.textTheme.body1.color)
        : theme.textTheme.button;

    return _HarpyButtonBase(
      onTap: onPressed,
      child: Material(
        color: color,
        elevation: 8,
        borderRadius: borderRadius,
        child: Padding(
          padding: padding,
          child: Text(title, style: style),
        ),
      ),
    );
  }
}

/// A flat button without a background that appears as text.
///
/// Should only be used when the context makes it clear it can be tapped.
class NewFlatHarpyButton extends StatelessWidget {
  const NewFlatHarpyButton({
    @required this.title,
    this.color,
    @required this.onPressed,
    this.dense = false,
  });

  final String title;
  final VoidCallback onPressed;
  final Color color;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(64);
    final padding = EdgeInsets.symmetric(
      vertical: dense ? 8 : 12,
      horizontal: dense ? 16 : 32,
    );

    // final theme = ThemeSettingsModel.of(context).harpyTheme.theme;
    final theme = ThemeData.light();

    return _HarpyButtonBase(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: Text(
          title,
          style: theme.textTheme.button.copyWith(
            color: color ?? theme.textTheme.body1.color,
          ),
        ),
      ),
    );
  }
}

/// A flat button with an icon in its center.
class IconHarpyButton extends StatelessWidget {
  const IconHarpyButton({
    @required this.iconData,
    @required this.onTap,
    this.dense = false,
  });

  final IconData iconData;
  final VoidCallback onTap;

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(64);
    final padding = EdgeInsets.symmetric(
      vertical: dense ? 8 : 12,
      horizontal: dense ? 16 : 32,
    );

    // final theme = ThemeSettingsModel.of(context).harpyTheme.theme;
    final theme = ThemeData.dark();

    final color = theme.textTheme.body1.color;

    return _HarpyButtonBase(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: padding,
          child: Icon(iconData, color: color),
        ),
      ),
    );
  }
}

/// A flat button with an icon in its center.
class RectButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;

  const RectButton({
    @required this.iconData,
    @required this.color,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            height: 60,
            width: 60,
            child: Icon(iconData, color: Colors.white, size: 35),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(14))));
  }
}

class CirleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final String title;

  const CirleButton(
      {Key key,
      @required this.color,
      @required this.onPressed,
      @required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.fromLTRB(96, 16, 96, 16),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        color: color ?? Color.fromRGBO(0, 122, 255, 1),
      ),
    );
  }
}
