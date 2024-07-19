import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/model/transction_type_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';
import 'package:theluckywin/view/account/transction_history.dart';

import '../../res/api_urls.dart';
import 'package:http/http.dart' as http;


class DepositBottom extends StatefulWidget {
  int id = 0;
  String name;
  DepositBottom({super.key, required this.id, required this.name});

  @override
  State<DepositBottom> createState() => _DepositBottomState();
}

class _DepositBottomState extends State<DepositBottom> {

  bool isLoading = false;

  @override
  void initState() {
    fetchTransactionTypes();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30,top: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: textWidget(
                text: 'Cancel',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Colors.black

            ),
          ),
        ),
    Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: transctionTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  final type = transctionTypes[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        widget.id = index;
                        widget.name = type.name.toString();
                      });
                      if (kDebugMode) {
                        print(widget.id );
                      }
                      Navigator.pop(context,{"name":widget.name});
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            type.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: widget.id  == index
                                  ? Colors.blue
                                  : AppColors.primaryTextColor, // Assuming AppColors.primaryTextColor is black
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        );
  }
  List<TransctionTypeModel> transctionTypes = [];
  Future<void> fetchTransactionTypes() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(ApiUrl.depositWithdrawlStatusList));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          transctionTypes = responseData
              .map((item) => TransctionTypeModel.fromJson(item))
              .toList();
        });
      } else if (response.statusCode == 401) {
        Navigator.pushNamed(context, RoutesName.loginScreen);
      } else {
        throw Exception('Failed to load transaction types');
      }
    } catch (e) {
      print('Error fetching transaction types: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

}
