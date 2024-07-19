import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:theluckywin/view/account/account_page_new.dart';
import 'package:theluckywin/view/activity/activity_screen.dart';
import 'package:theluckywin/view/home/offers_screen.dart';
import 'package:theluckywin/view/home/home_screen.dart';
import 'package:theluckywin/view/promotion/promotion_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theluckywin/view/wallet/wallet_screen_new.dart';
import 'widget/bottom_widget.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;
  const BottomNavBar({super.key, this.initialIndex=0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _lastSelected = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const ActivityScreen(),
    const PromotionScreenNew(),
    const WalletScreenNew(),
    const AccountPageNew(),
  ];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
    // TODO: implement initState
    super.initState();
    _lastSelected = widget.initialIndex;
    Future.delayed(const Duration(seconds: 2), () {
      showDialog(context: context, builder: (context)=>const OffersScreen());
    });

  }


  Future<bool> _onWillPop() async {
    if (_lastSelected > 0) {
      setState(() {
        _lastSelected=0;
      });
      return false;
    } else {
      return  await Utils.showExitConfirmation(context)?? false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.scaffolddark,
        body: _tabs[_lastSelected],
        bottomNavigationBar:
        FabBottomNavBar(
          color: AppColors.primaryTextColor,
          selectedColor:AppColors.gradientFirstColor,
          onTabSelected: _selectedTab,
          backgroundColor: Colors.transparent,
          items: [
            FabBottomNavBarItem(
                imageData: _lastSelected == 0 ? Assets.imagesHomeYellow:Assets.imagesHomeGrey,
                text: 'Home',
                   ontap: (){

                   }
            ),
            FabBottomNavBarItem(
              imageData: _lastSelected == 1 ? Assets.imagesTrophyYellow:Assets.imagesTrophyGrey,
              text: 'Activity',
                ontap: (){

                }
            ),
            FabBottomNavBarItem(
              text: '\n Promotion',
                ontap: (){

                }
            ),
            FabBottomNavBarItem(
              imageData:
              _lastSelected == 3 ? Assets.imagesWalletYellow:Assets.imagesWalletGrey,
              text: 'Wallet',
                ontap: (){

                }
            ),
            FabBottomNavBarItem(
              imageData: _lastSelected == 4 ? Assets.imagesAccountYellow:Assets.imagesAccountGrey,
              text: 'Account',
                ontap: (){


                }
            ),
          ],
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,

          onPressed: () {
              setState(() {
                _selectedTab(2);
                selectedIndex=2;
              });

          },
          elevation: 3,
          child: Container(
            height: 53,
              width: 53,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.gradientFirstColor,

              ),
              child: Image.asset(Assets.imagesDiamond,scale: 1.5,))
        ),
      )

    );
  }



}

class FeedbackProvider {
  static void navigateTohome(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 0);
  }
  static void navigateToActivity(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 1);
  }
  static void navigateToPromotion(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 2);
  }
  static void navigateToWallet(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 3);
  }
  static void navigateToAccount(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 4);
  }
}

class GradientTextview extends StatelessWidget {
  const GradientTextview(
      this.text, {
        super.key,
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
class NavigatorService {
  static void navigateToScreenThree(BuildContext context) {Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const BottomNavBar(initialIndex: 3)),
    );

  }


}
