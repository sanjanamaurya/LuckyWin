import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:theluckywin/model/custmer_service_model.dart';
import 'package:theluckywin/res/app_constant.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/main.dart';
import 'package:flutter/foundation.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/helper/api_helper.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:theluckywin/view/account/service_center/custmor_service.dart';
import 'package:theluckywin/view/home/notification.dart';
import 'package:theluckywin/view/home/widgets/category_elements.dart';
import 'package:theluckywin/view/home/widgets/category_widgets.dart';
import 'package:theluckywin/view/home/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:theluckywin/view/home/widgets/winning_information.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    versionCheck();
    customerServiceApi();
    invitationRuleApi();
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();
  int selectedCategoryIndex = 0;
  bool verssionview = false;

  Future<void> _refreshData() async {
    await Future.wait([
      versionCheck(),
      customerServiceApi(),
      invitationRuleApi(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<ProfileProvider>();

    _launchURL2() async {
      var url = userData.apkLink.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    _launchChannel() async {
      var url = "https://t.me/theluckywingame_official";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (kIsWeb) {
    } else {
      Future.delayed(const Duration(seconds: 3), () => showAlert(context));
    }

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title:  Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage:  AssetImage(
                  Assets.imagesSplashImage,
                ),
              ),
              textWidget(
                  text: " Lucky Win",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.065),
            ],
          ),
          actions: [
            kIsWeb == true
                ? Row(
              children: [
                IconButton(
                  onPressed: () {
                    _launchURL2();
                  },
                  icon: const Icon(Icons.download_for_offline,
                      color: AppColors.goldencolor),
                ),
                InkWell(
                  onTap: () {
                    _launchChannel();
                  },
                  child: Container(
                    width: width * 0.13,
                    height: height * 0.03,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.goldencolor),
                    child: const Center(
                        child: Text(
                          "Channel",
                          style: TextStyle(
                              color: Color(0xff374992),
                              fontSize: 13,
                              fontWeight: FontWeight.w900),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const NotificationScreen()));
                    },
                    child: Image.asset(
                      Assets.iconsProNotification,
                      height: 30,
                    ),
                  ),
                ),
              ],
            )
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const NotificationScreen()));
                },
                child: Image.asset(
                  Assets.iconsProNotification,
                  height: 30,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: DraggableFab(
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerCareService()));
            },
            child: Image.asset(
              Assets.iconsIconSevice,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const SliderWidget(),
                Container(
                  height: height * 0.07,
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.iconsMicphone,
                        height: 30,
                      ),
                      SizedBox(width: width * 0.01),
                      _rotate(),
                      Image.asset(
                        Assets.iconsNotification,
                        height: 30,
                      ),
                    ],
                  ),
                ),
                CategoryWidget(
                  onCategorySelected: (index) {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                ),
                CategoryElement(selectedCategoryIndex: selectedCategoryIndex),
                SizedBox(
                  height: height * 0.04,
                ),
                const WinningInformation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _rotate() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        DefaultTextStyle(
          style: const TextStyle(fontSize: 12, color: Colors.black),
          child: SizedBox(
            width: width * 0.75,
            child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: invitationRuleList.isEmpty
                  ? [RotateAnimatedText("")]
                  : invitationRuleList
                  .map((rule) => RotateAnimatedText(rule))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showAlert(BuildContext context) {
    verssionview == true
        ? showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.scaffolddark,
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.50,
                  height: height * 0.18,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesAppBarSecond),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Text('new version are available',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Text('Update your app  ${AppConstants.appVersion}  to  $map',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _launchURL();
                  if (kDebugMode) {
                    print(versionlink);
                    print("versionlink");
                  }
                },
                child: const Text("UPDATE"))
          ],
        ))
        : Container();
  }

  List<String> invitationRuleList = [];
  Future<void> invitationRuleApi() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.allRules}5'),
    );
    if (kDebugMode) {
      print('${ApiUrl.allRules}5');
      print('allRules');
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        invitationRuleList = json.decode(responseData[0]['list']).cast<String>();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        invitationRuleList = [];
      });
      throw Exception('Failed to load data');
    }
  }

  dynamic map;
  dynamic versionlink;

  Future<void> versionCheck() async {
    context.read<ProfileProvider>().fetchProfileData();
    if (kDebugMode) {
      print('aaaaaaaaaaaaaaaaaaaa');
    }
    final response = await http.get(
      Uri.parse(ApiUrl.versionlink),
    );
    if (kDebugMode) {
      print(jsonDecode(response.body));
    }
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
        print('rrrrrrrr');
      }
      if (responseData['version'] != AppConstants.appVersion) {
        setState(() {
          map = responseData['version'];
          versionlink = responseData['link'];
          verssionview = true;
        });
      } else {
        if (kDebugMode) {
          print('Version is up-to-date');
        }
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch version data');
      }
    }
  }

  _launchURL() async {
    var url = versionlink.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  var link;
  List<CustomerServiceModel> customerService = [];

  Future<void> customerServiceApi() async {
    final response = await http.get(
      Uri.parse(ApiUrl.customerService),
    );
    if (kDebugMode) {
      print(ApiUrl.customerService);
      print('getwayList+token');
    }

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        customerService =
            responseData.map((item) => CustomerServiceModel.fromJson(item)).toList();
        link = json.decode(response.body)['data'][2]['link'];
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        customerService = [];
      });
      throw Exception('Failed to load data');
    }
  }
}