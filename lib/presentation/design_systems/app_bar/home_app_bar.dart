
import 'package:thara/Presentation/design_systems/app_bar/base_app_bar.dart';

class HomeAppBar extends BaseAppBar {
  const HomeAppBar({super.key, required super.title})
      : super(showProfile: true, showNotification: true);
}
