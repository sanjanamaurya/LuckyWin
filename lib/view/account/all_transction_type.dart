// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/model/transction_type_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';

class TransctionType extends StatefulWidget {
  String selectedId;

  TransctionType({Key? key, required this.selectedId}) : super(key: key);

  @override
  TransctionTypeState createState() => TransctionTypeState();
}

class TransctionTypeState extends State<TransctionType> {
  List<TransctionTypeModel> transctionTypes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTransactionTypes();
  }

  Future<void> fetchTransactionTypes() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(ApiUrl.allTranscationType));

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: AppColors.filledColor,
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:(){
                    print(widget.selectedId);
                    Navigator.pop(context);
                  },
                  child: textWidget(
                    text: 'Cancel',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: widget.selectedId == '0'
                        ? Colors.blue
                        : AppColors.dividerColor,
                  ),
                ),
                textWidget(
                  text: 'Confirm',
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppColors.gradientFirstColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: transctionTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final transactionType = transctionTypes[index];
                      return InkWell(
                        onTap: () {
                          setState(() {

                            widget.selectedId = index.toString();
                          });
                          print(widget.selectedId);
                        },
                        child: Column(
                          children: [
                            Center(
                              child: textWidget(
                                text: transactionType.name,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: widget.selectedId == index.toString()
                                    ? Colors.blue
                                    : AppColors.primaryTextColor,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
