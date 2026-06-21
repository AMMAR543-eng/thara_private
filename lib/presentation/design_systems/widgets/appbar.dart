import '../../../index/index.dart';

class AppBarWithTitleAndActions extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWithTitleAndActions({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.elevation,
    this.backgroundColor,
    this.centerTitle,
    this.toolbarHeight,
    this.bottom,
    this.iconTheme,
    this.shape,
  });

  /// The title to display in the AppBar.
  final String? title;

  /// The leading widget to display before the title (typically a back button).
  final Widget? leading;

  /// The actions to display in the AppBar (typically icons).
  final List<Widget>? actions;

  /// The elevation of the AppBar.
  final double? elevation;

  /// The background color of the AppBar.
  final Color? backgroundColor;

  /// Whether the title should be centered in the AppBar.
  final bool? centerTitle;

  /// The height of the toolbar in the AppBar.
  final double? toolbarHeight;

  /// The bottom widget to display in the AppBar (typically a TabBar).
  final PreferredSizeWidget? bottom;

  /// The icon theme for the AppBar icons.
  final IconThemeData? iconTheme;

  /// The shape of the AppBar.
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = context.appBarTheme;

    return AppBar(
      key: key,
      title: Text(
        title ?? '',
        style: context.typography.smallTitle39,
      ),
      leading: leading,
      actions: actions,
      elevation: elevation ?? appBarTheme.elevation,
      backgroundColor: backgroundColor ?? appBarTheme.backgroundColor,
      centerTitle: centerTitle ?? appBarTheme.centerTitle,
      toolbarHeight: toolbarHeight ?? appBarTheme.toolbarHeight,
      bottom: bottom,
      iconTheme: iconTheme ?? appBarTheme.iconTheme,
      shape: shape ?? appBarTheme.shape,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
