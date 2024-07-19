import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/model/change_avtar_List_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/helper/api_helper.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/utils.dart';

import '../../../res/api_urls.dart';
import 'package:http/http.dart'as http;
class ChangeAvtar extends StatefulWidget {
  const ChangeAvtar({super.key});

  @override
  State<ChangeAvtar> createState() => _ChangeAvtarState();
}

class _ChangeAvtarState extends State<ChangeAvtar> {
  int selectedIndex = -1;
  @override
  void initState() {
    changeAvtarApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                )),
          ),
          centerTitle: true,
          title: textWidget(
            text: 'Change avatar',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: Colors.white,
          ),
          gradient: AppColors.primaryUnselectedGradient),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:changeAvtar.isEmpty?const Center(child: CircularProgressIndicator()):
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: changeAvtar.length,
          itemBuilder: (context, index) {
            final bool isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                avtarChangeApi(image:changeAvtar[index].image.toString());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                                image: NetworkImage(changeAvtar[index].image.toString(),
                        ))),
                      ),
                      isSelected ?
                      const Align(
                        alignment: Alignment.bottomRight,
                          child: Icon(Icons.check_circle,color: AppColors.gradientFirstColor,)):Container()

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();



  UserViewProvider userProvider = UserViewProvider();

  List<ChangeAvtarModel> changeAvtar = [];
  Future<void> changeAvtarApi() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.changeAvtarList),);
    if (kDebugMode) {
      print(ApiUrl.changeAvtarList);
      print('changeAvtarList');

    }


    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        changeAvtar = responseData.map((item) => ChangeAvtarModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        changeAvtar = [];
      });
      throw Exception('Failed to load data');
    }
  }


  avtarChangeApi({required String image}) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.UpdateAvtarApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": token,
        "userimage": image,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    if (data["status"] == 200) {

       context.read<ProfileProvider>().fetchProfileData();
      // fetchData();
      Navigator.pop(context);
      return Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else if (data["status"] == 401) {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }
}

