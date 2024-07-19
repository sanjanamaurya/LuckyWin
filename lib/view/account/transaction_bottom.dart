import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/model/all_transction_model.dart';
import 'package:theluckywin/model/transction_type_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';
import 'package:theluckywin/view/account/transction_history.dart';

import '../../res/api_urls.dart';
import 'package:http/http.dart' as http;


class TransactionBottom extends StatefulWidget {
  int id = 0;
  String name;
   TransactionBottom({super.key, required this.id, required this.name});

  @override
  State<TransactionBottom> createState() => _TransactionBottomState();
}

class _TransactionBottomState extends State<TransactionBottom> {

  bool isLoading = false;
  DateTime? _selectedDate;


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
              final transactionType = transctionTypes[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    widget.id = transactionType.id;
                    widget.name=transactionType.name;

                    fetchTransactionTypes();
                  });
                  allTransctionHistory();
                  if (kDebugMode) {
                    print(widget.id);
                  }
                  Navigator.pop(context,{"name":widget.name});

                },
                child: Column(
                  children: [
                    Center(
                      child: textWidget(
                        text: transactionType.name,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: widget.id == transactionType.id
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.height * 0.02,
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
  List<AllTransactionModel> allTransactions = [];
  UserViewProvider userProvider = UserViewProvider();

  int? responseStatusCode;
  Future<void> allTransctionHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(

      Uri.parse(_selectedDate==null?'${ApiUrl.allTranscation}$token&subtypeid=${widget.id}':'${ApiUrl.allTranscation}$token&subtypeid=${widget.id}&created_at=$_selectedDate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(_selectedDate==null?'${ApiUrl.allTranscation}$token&subtypeid=${widget.id}':'${ApiUrl.allTranscation}$token&subtypeid=${widget.id}&created_at=$_selectedDate');



    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      print(responseData);
      print("responseData");
      setState(() {
        allTransactions = responseData.map((item) => AllTransactionModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
    } else {
      setState(() {
        allTransactions = [];
      });
      throw Exception('Failed to load transaction history');
    }
  }
}
