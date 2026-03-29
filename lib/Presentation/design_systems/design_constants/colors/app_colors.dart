import 'package:thara/Global/theme/local_storage_theme.dart';

import '../../../../index/index_main.dart';

class AppColors {
  AppColors._();

  // =========================
  // 🔹 DARK MODE FLAG
  // =========================
  static bool get _isDark {
    final theme = LocalStorageTheme().read();
    return theme == 'dark';
  }

  // =========================
  // 🔹 PRIMARY / BRAND
  // =========================
  static Color get primary =>
      _isDark ? const Color(0xFF6EB3B6) : const Color(0xFF272E35);

  static Color get primary_normal =>
      _isDark ? const Color(0xFF6EB3B6) : const Color(0xFF163637);

  static Color get primary_active =>
      _isDark ? const Color(0xFF0A9A8F) : const Color(0xFF0C2121);

  // =========================
  // 🔹 BACKGROUNDS
  // =========================
  static Color get white =>
      _isDark ? const Color(0xFF1F3737) : const Color(0xFFFFFFFF);

  static Color get white_dark =>
      _isDark ? const Color(0xFF6EB3B6) : const Color(0xFFFFFFFF);

  static Color get background_neutral_surface =>
      _isDark ? const Color(0xFF335255) : const Color(0xFFFCFCFD);

  static Color get background_neutral_default =>
      _isDark ? const Color(0xFF002825) : const Color(0xFFF3F4F6);

  static Color get background_black =>
      _isDark ? const Color(0xFF002825) : const Color(0xFF161616);

  static Color get black =>
      _isDark ? const Color(0xFFF3F4F6) : const Color(0xFF161616);

  static Color get black_color => const Color(0xFF161616);

  // =========================
  // 🔹 TEXT COLORS
  // =========================
  static Color get textDefault =>
      _isDark ? const Color(0xFFEAF2F1) : const Color(0xFF161616);

  static Color get content_secondary =>
      _isDark ? const Color(0xFFCFE1DF) : const Color(0xFF555F6D);

  static Color get field_text_placeholder =>
      _isDark ? const Color(0xFF8FAEAC) : const Color(0xFF6C737F);

  static Color get content_brand_secondary =>
      _isDark ? const Color(0xFFB3C5C4) : const Color(0xFF163637);

  static Color get text_primary_paragraph =>
      _isDark ? const Color(0xFFB3C5C4) : const Color(0xFF384250);

  // =========================
  // 🔹 INPUTS / BORDERS
  // =========================
  static Color get border_default =>
      _isDark ? const Color(0xFF2A3F3F) : const Color(0xFFEAEDF0);

  static Color get border_Neutral_Subtle =>
      _isDark ? const Color(0xFF2A3F3F) : const Color(0xFFCFD6DD);

  static Color get focus_input_text =>
      _isDark ? const Color(0xFF6EB3B6) : const Color(0xFF1B7174);

  static Color get action_primary_normal =>
      _isDark ? const Color(0xFF6EB3B6) : const Color(0xFF163637);

  // =========================
  // 🔹 STATES
  // =========================
  static Color get interaction_Disabled_Normal =>
      _isDark ? const Color(0xFF5C6F6E) : const Color(0xFF9EA8B3);

  static Color get action_natural_normal =>
      _isDark ? const Color(0xFFB3C5C4) : const Color(0xFF4A545E);

  static Color get action_outline_normal =>
      _isDark ? const Color(0xFF2A3F3F) : const Color(0xFFCFD6DD);

  static Color get content_primary =>
      _isDark ? const Color(0xFFEAF2F1) : const Color(0xFF272E35);

  // Primary Colors
  static const darkJungleGreen = Color(0xFF0d2725);
  static const mediumJungleGreen = Color(0xFF1f3737);
  static const date_picker_background = Color(0xB2A6A6A6);

  static Color get whiteSmoke =>
      _isDark ? const Color(0xFF2A3F3F) : const Color(0xFFF7F7F7);

  static Color get background_Neutral_Subtle =>
      _isDark ? const Color(0xFF2A3F3F) : const Color(0xFFF5F7F9);

  static Color get interaction_Neutral_Subtle_Normal =>
      _isDark ? const Color(0xFF2A3F3F) : const Color(0xFFF0F3F5);

  static Color get background_neutral_25 =>
      _isDark ? const Color(0xFF1F3737) : const Color(0xFFFCFCFD);
  static const content_Informative_Primary = Color(0xFF113997);

  static const outline_normal = Color(0xFFCFD6DD);
  static const content_positive_secondary = Color(0xFF1B7174);
  static const interaction_defacult_normal = Color(0xFF163637);
  static const content_brand_primary = Color(0xFF0C2121);
  static const interaction_Default_SubtleNormal = Color(0xFFC0CECF);

  static const brand_bold = Color(0xFF379692);

  static Color get background_banner =>
      _isDark ? const Color(0xFF1F3737) : const Color(0xFFF2F6F7);
  static const background_Positive_Subtle = Color(0xFFF4FBF7);
  static const green_light = Color(0xFF0A9A8F);

  static const lightBlue = Color(0xFF4DA6FF); // غيره حسب الديزاين

  static const tertiary = Color(0xFF7E8C9A);
  static const border_natural_normal = Color(0xFFCFD6DD);

  static const moonstoneBlue = Color(0xFF6EB3B6);
  static const argent = Color(0xFFbfbfbf);
  static const fawn = Color(0xFFE2A976);
  static const goldCrayola = Color(0xFFE4BE98);
  static const whiteChocolate = Color(0xFFF3E3D5);

  static const saratoga = Color(0xFF5D5B2D);
  static const yellowMetal = Color(0xFF7C793C);
  static const greenSmoke = Color(0xFFa4a552);
  static const oceanGreen = Color(0xFF549870);
  static const butteredRum = Color(0xFF957833);
  static const sundance = Color(0xFFC7A044);
  static const metallicGold = Color(0xFFD8AF46);
  static const crimson = Color(0xFFD31636);
  static const riverBed = Color(0xFF606161);
  static const darkGray = Color(0xFFA7A7A7);
  static const greyLight = Color(0xFFF5F5F5);
  static const greyDark = Color(0xFF969696);

  // Success Colors
  static const Color successBackground = Color(0xFFE8F5E9); // Light Green
  static const Color successForeground = Color(0xFF4CAF50); // Success Green

  // Error Colors
  static const Color errorBackground = Color(0xFFFEF3F3); // Light Red
  static const Color errorForeground = Color(0xFFF14837); // Error Red
  static const Color action_Destructive_Normal = Color(0xFFC53434); // Error Red

  // Divider and Lines
  static const Color dividerAndLines = Color(
    0xFFE0E0E2,
  ); // Grayscale Light Lines

  // Background Colors
  static const Color backgroundPrimary = Color(
    0xFF161616,
  ); // Background primary
  static const Color backgroundSecondary = Color(
    0xFF6C737F,
  ); // Background secondary

  // Blue Colors
  static const Color blueLightBackground = Color(0xFFD0E8FF); // Light Blue
  static const Color blueForeground = Color(0xFF4A90E2); // Blue Foreground
  static const Color blue = Color(0xFF006EB6); // Blue Foreground

  // Yellow Colors
  static const Color yellowBackground = Color(0xFFFFF8E8);
  static const Color yellowForeground = Color(0xFFF5A100);

  // Grayscale Colors
  static const Color grayLight = Color(0xFFE0E0E2);
  static const Color grayMedium = Color(0xFF8C8C8C);
  static const Color buttonDisabledTextColor = Color(0xFF9DA4AE);
  static const Color buttonDisabledColor = Color(0xFFE5E7EB);
  static const Color buttonpressedColor = Color(0xFF4D5761);

  // Shadow Settings
  static const Color shadowUpper = Color(0xFF8F8F8F);
  static const double shadowOpacity = 0.2;
  static const double shadowBlur = 20.0;
  static const double shadowOffsetX = 0.0;
  static const double shadowOffsetY = -4.0;

  // Gradients
  static const Gradient greenGradient = LinearGradient(
    colors: [Color(0xFFC7DAB4), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient goldGradient = LinearGradient(
    colors: [Color(0xFFF9EAD7), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // colors
  // Text Colors
  static const Color textDisplay = Color(0xFF1F2A37); // Text/text-display
  static const Color textSecondaryParagraph = Color(
    0xFF6C737F,
  ); // Text/text-secondary-paragraph
  static const Color formFieldTextLabel = Color(
    0xFFEAF2F1,
  ); // Form/field-text-label

  static const Color text_steeper = Color(0xFF384250);

  static const Color textFieldPlaceholder = Color(
    0xFF6C737F,
  ); // Text/text-default
  static const Color textFieldBorderDefault = Color(0xFF9DA4AE); // Medium gray
  static const Color textFieldBorderFocused = Color(0xFF6EB3B6); // Medium gray
  static const Color textFieldBackgroundFocused = Color(0xFFF3F4F6);
  static const Color borderNeutralPrimary = Color(0xFFD2D6DB);
  static const Color textFormTitle = Color(0xFF161616);

  static const Color backgroundBlackDefault = Color(0xFF0D121C);

  static const Color background_warning_light = Color(0xFFFFFAEB);

  static const Color background_error_light = Color(0xFFFEF3F2);

  static const Color tag_icon_warning = Color(0xFF93370D);

  static const Color tag_text_error = Color(0xFF912018);
  static const Color background_neutral_100 = Color(0xFFF3F4F6);
  static const Color background_neutral_800 = Color(0xFF1F2A37);
  static const Color background_info_50 = Color(0xFFEFF8FF);
  static const Color text_info = Color(0xFF175CD3);
  static const Color background_primary_default = Color(0xFF1B8354);

  // badge

  static const Color closed_background = Color(0xFFB54708);
  static const Color closed_text = Color(0xFFB54708);
  static const Color pending = Color(0xFF1570EF);
  static const brass = Color(0xFFa3a645);
}
