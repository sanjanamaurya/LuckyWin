import 'package:flutter/foundation.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Usdtweb extends StatefulWidget {
  final String url;

  const Usdtweb({super.key, required this.url});

  @override
  _UsdtwebState createState() =>
      _UsdtwebState();
}
class _UsdtwebState extends State<Usdtweb> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.url);
      print('wwwwww');
    }


    return SafeArea(
      child: Scaffold(
        appBar: GradientAppBar(
            leading: const AppBackBtn(),
            title: textWidget(
                text: 'Pay', fontSize: 25, color: AppColors.primaryTextColor),
            gradient: AppColors.primaryGradient),
        body: Column(
          children: <Widget>[
            if (_isLoading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white, // Set your desired background color
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            Expanded(
              child: WebView(
                backgroundColor: Colors.transparent,
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                  webViewController.clearCache();
                  final cookieManager = CookieManager();
                  cookieManager.clearCookies();
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('upi://')) {
                    launch(request.url);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  setState(() {
                    _isLoading = true;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ),

            // AppBtn(
            //   onTap: () {
            //     _settingModalBottomSheet(context);
            //   },
            //   hideBorder: true,
            //   title: 'Add Screenshot',
            //   gradient: AppColors.primaryappbargrey,
            // ),
          ],
        ),
      ),
    );
  }
  // String myData = '0';
  // void _updateImage(ImageSource imageSource) async {
  //   String? imageData = await ChooseImage.chooseImageAndConvertToString(imageSource);
  //   if (imageData != null) {
  //     setState(() {
  //       myData = imageData;
  //     });
  //   }
  // }
  // void _settingModalBottomSheet(context) {
  //   final heights = MediaQuery.of(context).size.height;
  //   final widths = MediaQuery.of(context).size.width;
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(15), topRight: Radius.circular(15)),
  //       ),
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SizedBox(
  //           height: heights / 7,
  //           child: Padding(
  //             padding: EdgeInsets.fromLTRB(
  //                 widths / 12, 0, widths / 12, heights / 60),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 InkWell(
  //                   onTap: () {
  //                     _updateImage(ImageSource.camera);
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     height: heights / 20,
  //                     width: widths / 2.7,
  //                     decoration: BoxDecoration(
  //                       // color: Colors.blue,
  //                         border: Border.all(color: Colors.red, width: 2),
  //                         borderRadius: BorderRadius.circular(10)),
  //                     child: const Center(
  //                         child: Text(
  //                           "Camera",
  //                           style: TextStyle(color: Colors.red),
  //                         )),
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     _updateImage(ImageSource.gallery);
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     height: heights / 20,
  //                     width: widths / 2.7,
  //                     decoration: BoxDecoration(
  //                         color: Colors.red,
  //                         borderRadius: BorderRadius.circular(10)),
  //                     child: const Center(
  //                         child: Text(
  //                           "Gallery",
  //                         )),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}