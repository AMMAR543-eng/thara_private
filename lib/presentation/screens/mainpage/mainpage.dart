import 'package:lottie/lottie.dart';

import '../../../index/index_main.dart';

class MainPage extends StatefulWidget {
  int indexNum;
  String? keyValue;
  int? inner_index;

  MainPage({Key? key, this.indexNum = 0, this.keyValue, this.inner_index})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pressed = 0;
  static const int backPressThreshold = 2;

  final Color activeColor = LocalStorageTheme().read() == 'dark'
      ? Colors.white
      : AppColors.content_brand_secondary;

  final Color inactiveColor = AppColors.darkGray;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: _getBody(widget.indexNum),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (pressed < backPressThreshold) {
      setState(() => pressed++);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${"press_back".tr} ${backPressThreshold + 1 - pressed} ${"more_times_to_close".tr}',
          ),
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  Widget _buildBottomNavigationBar() {
    final bool isAuthenticated =
        LoginResponseModel().getTokenData()?.data?.accessToken != null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(color: AppColors.grayMedium, width: 0.25),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              animationFile: _getAnimation("home"),
              label: "home".tr,
              index: 0,
            ),
            _buildNavItem(
              animationFile: _getAnimation("more"),
              label: "opportunities".tr,
              index: 1,
            ),
            _buildNavItem(
              animationFile: _getAnimation("transfer"),
              label: "transactions".tr,
              index: 2,
            ),
            _buildNavItem(
              animationFile: _getAnimation("wallet"),
              label: "wallet".tr,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  String _getAnimation(String type) {
    final bool isLight = LocalStorageTheme().read() == "light";

    switch (type) {
      case "home":
        return isLight ? Animations.home : Animations.home_dark;

      case "more":
        return isLight ? Animations.more : Animations.more_dark;

      case "transfer":
        return isLight ? Animations.transfer_dark : Animations.transfer;

      case "wallet":
        return isLight ? Animations.wallet : Animations.wallet_dark;

      default:
        return Animations.home;
    }
  }

  /// 🔹 Navigation item with icon + label
  Widget _buildNavItem({
    required String animationFile,
    required String label,
    required int index,
  }) {
    final bool isActive = widget.indexNum == index;

    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 32,
            width: 32,
            child: Lottie.asset(
              animationFile,
              repeat: true,
              reverse: false,
              animate: isActive,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: context.typography.bodyMedium.copyWith(
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() => widget.indexNum = index);
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const AllForsa();
      case 2:
        return const ProcessView();
      case 3:
        return const WalletView();
      default:
        return Center(child: Text("invalid_index".tr));
    }
  }
}

/// 🔹 Controller
class MainPageController extends GetxController {
  String? name;
  final token = LoginResponseModel().getTokenData()?.data?.accessToken;
  final registrationStage =
      const AccountModel().getAccountLocal()?.registrationStage;
  final passTwoFactor = UserModel().getUserData()?.passTwoFactor;

  @override
  void onInit() {
    super.onInit();
    if (token != null && passTwoFactor == true) {
      getMeData();
    } else {
      name = "visitor".tr;
    }
  }

  void getMeData() {
    AuthService().me(
      voidCallBack: (data) {
        name = data.user?.name ?? "";
        update();
      },
    );
  }
}
