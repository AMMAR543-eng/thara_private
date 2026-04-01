import '../../../index/index.dart';

const _kThemeMode = 'themeMode';

class ThemeScopeWidget extends StatefulWidget {
  /// {@macro theme_scope_widget}
  const ThemeScopeWidget({
    super.key,
    required this.child,
    required this.preferences,
  });

  /// The child widget
  final Widget child;

  /// The shared preferences
  final SharedPreferences preferences;

  /// Initialize the [ThemeScopeWidget] with the given [child] widget
  static Future<ThemeScopeWidget> initialize(Widget child) async {
    final preferences = await SharedPreferences.getInstance();
    return ThemeScopeWidget(
      preferences: preferences,
      child: child,
    );
  }

  /// Access the state بسهولة
  static ThemeScopeWidgetState? of(BuildContext context) {
    return context.findRootAncestorStateOfType<ThemeScopeWidgetState>();
  }

  @override
  State<ThemeScopeWidget> createState() => ThemeScopeWidgetState();
}

class ThemeScopeWidgetState extends State<ThemeScopeWidget> {
  ThemeMode? _themeMode;

  /// Change the theme mode
  Future<void> changeTo(ThemeMode themeMode) async {
    if (_themeMode == themeMode) return;

    try {
      final index = ThemeMode.values.indexOf(themeMode);
      await widget.preferences.setInt(_kThemeMode, index);

      setState(() {
        _themeMode = themeMode;
      });
    } catch (e, stack) {
      debugPrint('❌ Theme change failed: $e');
      debugPrint(stack.toString());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    try {
      final themeModeIndex = widget.preferences.getInt(_kThemeMode);

      if (themeModeIndex == null ||
          themeModeIndex < 0 ||
          themeModeIndex >= ThemeMode.values.length) {
        throw Exception('Invalid theme index: $themeModeIndex');
      }

      _themeMode = ThemeMode.values[themeModeIndex];
    } catch (e, stack) {
      debugPrint('❌ Theme initialization failed: $e');
      debugPrint(stack.toString());

      _themeMode = ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    // fallback safety (extra protection)
    final currentMode = _themeMode ?? ThemeMode.system;

    final brightness = MediaQuery.platformBrightnessOf(context);

    final appTheme = switch (currentMode) {
      ThemeMode.light => AppTheme.light(),
      ThemeMode.dark => AppTheme.light(),
      ThemeMode.system =>
        brightness == Brightness.dark ? AppTheme.light() : AppTheme.light(),
    };

    return ThemeScope(
      themeMode: currentMode,
      appTheme: appTheme,
      child: widget.child,
    );
  }
}
