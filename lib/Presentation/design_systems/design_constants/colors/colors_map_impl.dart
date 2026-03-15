import '../../../../index/index.dart';

class ColorMappingImpl implements ColorMapping {
  // ===================== TEXT COLORS =====================
  @override
  Color get labelTextColor => AppColors.textFieldPlaceholder;

  @override
  Color get hintTextColor => AppColors.textFieldPlaceholder;

  @override
  Color get focusedTextColor => AppColors.black;

  @override
  Color get errorTextColor => AppColors.errorForeground;

  @override
  Color get disabledTextColor => AppColors.grayMedium;

  @override
  Color get textDisplay => AppColors.textDisplay;

  @override
  Color get textSecondaryParagraph => AppColors.textSecondaryParagraph;

  @override
  Color get textLabel => AppColors.formFieldTextLabel;

  @override
  Color get textDefault => AppColors.textDefault;

  @override
  Color get white => AppColors.white;

  @override
  Color get field_text_placeholder => AppColors.field_text_placeholder;

  // ===================== BORDER COLORS =====================
  @override
  Color get borderDefault => AppColors.border_natural_normal;

  @override
  Color get borderFocused => AppColors.focus_input_text;

  @override
  Color get borderError => AppColors.errorForeground;

  @override
  Color get borderDisabled => AppColors.border_natural_normal;

  @override
  Color get borderNeutralPrimary => AppColors.primary;

  // ===================== BACKGROUND COLORS =====================
  @override
  Color get backgroundDefault => AppColors.white;

  @override
  Color get backgroundFocused => AppColors.textFieldBackgroundFocused;

  @override
  Color get backgroundDisabled => AppColors.grayLight;

  @override
  Color get background_black_default => AppColors.backgroundBlackDefault;

  @override
  Color get background_error_light => AppColors.background_error_light;

  @override
  Color get background_neutral_default => AppColors.background_neutral_default;

  @override
  Color get background_warning_light => AppColors.background_warning_light;

  @override
  Color get background_neutral_100 => AppColors.background_neutral_100;

  // ===================== BUTTON COLORS =====================
  @override
  Color get primaryButtonDefault => AppColors.primary_normal;

  @override
  Color get primaryButtonFocused => AppColors.primary_normal;

  @override
  Color get primaryButtonEnabled => AppColors.primary_active;

  @override
  Color get primaryTextButton => AppColors.white;

  @override
  Color get buttonDisableColor => AppColors.interaction_Disabled_Normal;

  @override
  Color get buttonDisabledTextColor => AppColors.white;

  @override
  Color get secondaryButtonDefault => AppColors.goldCrayola;

  @override
  Color get secondaryButtonHover => AppColors.goldCrayola;

  @override
  Color get secondaryButtonFocused => AppColors.goldCrayola;

  @override
  Color get secondaryButtonEnabled => AppColors.primary;

  @override
  Color get secondaryButtonText => AppColors.primary;

  @override
  Color get outlineButtonDefault => AppColors.primary.withOpacity(0.4);

  @override
  Color get outlineButtonHover => AppColors.primary.withOpacity(0.6);

  @override
  Color get outlineButtonFocused => AppColors.primary.withOpacity(0.8);

  @override
  Color get outlineButtonEnabled => AppColors.primary.withOpacity(0.2);

  @override
  Color get outlineButtonText => AppColors.primary;

  // ===================== TAG COLORS =====================
  @override
  Color get tag_icon_warning => AppColors.tag_icon_warning;

  @override
  Color get tag_text_error => AppColors.tag_text_error;

  @override
  // TODO: implement primaryButtonHover
  Color get primaryButtonHover => AppColors.tag_text_error;
}
