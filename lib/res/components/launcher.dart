import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Launcher{
  static void openwhatsapp(context) async{
    var whatsapp ="+919565183872";
    var whatsappurlAndroid = "whatsapp://send?phone=$whatsapp&text=hello";
    var whatappurlIos ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if( await canLaunch(whatsappurlAndroid)){
      await launch(whatsappurlAndroid);
    }else{
      ScaffoldMessenger.of(context ).showSnackBar(
          const SnackBar(content:  Text("whatsapp not installed")));

    }
  }

  static void  linkurl() async {
    const url = 'https://www.geeksforgeeks.org/';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  String email="general@rootsgoods.com";
  _launchEmail() async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }
  static void  linkurlnew() async {
    const url = 'https://www.whatsapp.com/';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

}


