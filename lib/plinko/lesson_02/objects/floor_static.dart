import 'dart:convert';
import 'dart:io';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theluckywin/Plinko/my_game.dart';
import 'package:theluckywin/model/plinko_result.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/plinko/lesson_02/objects/ball_dynamic.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/plinko/utils/plinko_loss_popup.dart';
import 'package:theluckywin/plinko/utils/plinko_win_popup.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flame/extensions.dart';
import 'dart:ui' as ui;


//
// class FloorStatic extends BodyComponent with ContactCallbacks {
//   final Color color;
//   late final Paint _paint;
//
//   FloorStatic({this.color = Colors.transparent}) {
//     _paint = Paint()..color = color;
//   }
//
//   @override
//   Body createBody() {
//     final bodyDef = BodyDef(
//       userData: this,
//       position: Vector2(0, worldSize.y - .75),
//       type: BodyType.static,
//     );
//
//     final shape = EdgeShape()
//       ..set(Vector2.zero(), Vector2(worldSize.x, 0));
//     final fixtureDef = FixtureDef(shape);
//     return world.createBody(bodyDef)
//       ..createFixture(fixtureDef);
//   }
//
//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     final rect = Rect.fromLTWH(0, worldSize.y - .75, worldSize.x, 0.75);
//     canvas.drawRect(rect, _paint);
//   }
//
//   @override
//   void beginContact(Object other, Contact contact) {
//     if (other is BallDynamic) {
//       final contactPoint = contact.manifold.localPoint;
//       print("Ball has fallen at position: $contactPoint");
//
//       final ballPositions = contact.bodyB.position;
//       final ballPosition = ballPositions.x;
//       print("Ball has fallen only: ${ballPositions.x}");
//
//       plinkoBet(ballPosition);
//     }
//   }
//
//   @override
//   void endContact(Object other, Contact contact) {
//     if (other is BallDynamic) {
//       print("End of contact between ball and floor");
//     }
//   }
//
//   int generateScore(double pos, int old) {
//     return old;
//   }
//
//   UserViewProvider userProvider = UserViewProvider();
//
//   String processBallPosition(double ballPosition) {
//     if (ballPosition >= 1.0 && ballPosition <= 2.42) {
//       return '0';
//     } else if (ballPosition > 2.42 && ballPosition <= 3.84) {
//       return '1';
//     } else {
//       return '2';
//     }
//   }
//
//   String SetIndex = '';
//
//   plinkoBet(double ballPosition) async {
//     UserModel user = await userProvider.getUser();
//     String token = user.id.toString();
//     print(token);
//     print("token");
//     print("ballPosition");
//     print(ballPosition);
//
//     if (ballPosition >= 1.0 && ballPosition <= 2.42) {
//       SetIndex = '0';
//     } else if (ballPosition > 2.42 && ballPosition <= 3.84) {
//       SetIndex = '1';
//     } else if (ballPosition > 3.84 && ballPosition <= 5.26) {
//       SetIndex = '2';
//     } else if (ballPosition > 5.26 && ballPosition <= 6.68) {
//       SetIndex = '3';
//     } else if (ballPosition > 6.68 && ballPosition <= 8.1) {
//       SetIndex = '4';
//     } else if (ballPosition > 8.1 && ballPosition <= 9.52) {
//       SetIndex = '5';
//     } else if (ballPosition > 9.52 && ballPosition <= 10.94) {
//       SetIndex = '6';
//     } else if (ballPosition > 10.94 && ballPosition <= 12.36) {
//       SetIndex = '7';
//     } else if (ballPosition > 12.36) {
//       SetIndex = '8';
//     } else if (ballPosition > 1.0) {
//       SetIndex = '9';
//     }
//
//     print(SetIndex);
//     print('SetIndex');
//
//     final response = await http.post(
//       Uri.parse(ApiUrl.plinkoMultiplier),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{"userid": token, "index": SetIndex}),
//     );
//
//     if (response.statusCode == 200) {
//       print('api chalegi yaha');
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       print(responseData);
//       print("responseData");
//       fetchPlinkoData();
//       return Fluttertoast.showToast(msg: responseData['message']);
//     } else {
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       return Fluttertoast.showToast(msg: responseData['message']);
//     }
//   }
//
//   String? type;
//   String? multipler;
//   String? win_amount;
//
//   Future<List<PlinkoBetHistory>?> fetchPlinkoBet() async {
//     UserModel user = await userProvider.getUser();
//     String token = user.id.toString();
//
//     try {
//       final response = await http
//           .get(Uri.parse(ApiUrl.plinkoBetHistory + "userid=$token&limit=1"))
//           .timeout(const Duration(seconds: 10));
//       print(ApiUrl.plinkoBetHistory + "userid=$token&limit=1");
//       print("ApiUrl.plinkoBetHistory");
//       print(response);
//       print("response bet history");
//
//       if (response.statusCode == 200) {
//         final jsonList = json.decode(response.body);
//         print(jsonList);
//         print("jsonList");
//         if (jsonList['status'] == 200) {
//           final List<dynamic> data = json.decode(response.body)['data'];
//           if (data.isNotEmpty) {
//             type = data[0]['type'].toString();
//             multipler = data[0]['multipler'].toString();
//             win_amount = data[0]['win_amount'].toString();
//             print(type);
//             print("type");
//             print(multipler);
//             print("multipler");
//             print(win_amount);
//             print("win_amount");
//           }
//           List<PlinkoBetHistory> plinkolist = data
//               .map((jsonMap) => PlinkoBetHistory.fromJson(jsonMap))
//               .toList();
//           win_amount != '0'
//               ? ToastHelper.showwin(subtext1: type, subtext2: win_amount)
//               : ToastLostHelper.showloss(subtext1: type, subtext2: win_amount);
//
//           return plinkolist;
//         } else {
//           print("else");
//           return null;
//         }
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } on SocketException {
//       throw Exception('No Internet connection');
//     }
//   }
//
//   Future<void> fetchPlinkoData() async {
//     try {
//       List<PlinkoBetHistory>? plinkoBetData = await fetchPlinkoBet();
//       if (kDebugMode) {
//         print(plinkoBetData);
//         print("plinkoBetData");
//       }
//     } catch (error) {
//       print('Error fetching plinko data: $error');
//     }
//   }
// }


class FloorStatic extends BodyComponent with ContactCallbacks {
  final Color color;
  late final Paint _paint;

  FloorStatic({this.color = Colors.transparent}) {
    _paint = Paint()..color = color;
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(0, worldSize.y - .75),
      type: BodyType.static,
    );

    final shape = EdgeShape()
      // ..set(Vector2.zero(), Vector2(0, 0));
      ..set(Vector2.zero(), Vector2(worldSize.x, 0));
    final fixtureDef = FixtureDef(shape);
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef);
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    final rect = Rect.fromLTWH(0, worldSize.y - .75, worldSize.x, 0.75);
    canvas.drawRect(rect, _paint);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is BallDynamic) {
      final contactPoint = contact.manifold.localPoint;
      print("Ball has fallen at position: $contactPoint");

      final ballPositions = contact.bodyB.position;
      final ballPosition = ballPositions.x;
      print("Ball has fallen only: ${ballPositions.x}");

      plinkoBet(ballPosition);
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is BallDynamic) {
      print("End of contact between ball and floor");
    }
  }

  int generateScore(double pos, int old) {
    return old;
  }

  UserViewProvider userProvider = UserViewProvider();

  String processBallPosition(double ballPosition) {
    if (ballPosition >= 1.0 && ballPosition <= 2.42) {
      print(ballPosition);
      print('rtu9o;opk7uy6');
      return '0';
    } else if (ballPosition > 2.42 && ballPosition <= 3.84) {
      return '1';
    } else {
      return '2';
    }
  }

  String SetIndex = '';

  plinkoBet(double ballPosition) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    print(token);
    print("token");
    print("ballPosition");
    print(ballPosition);

    if (ballPosition >= 1.0 && ballPosition <= 2.42) {
      SetIndex = '1';
    } else
      if (ballPosition > 2.42 && ballPosition <= 3.84) {
      SetIndex = '2';
    } else if (ballPosition > 3.84 && ballPosition <= 5.26) {
      SetIndex = '3';
    } else if (ballPosition > 5.26 && ballPosition <= 6.68) {
      SetIndex = '4';
    } else if (ballPosition > 6.68 && ballPosition <= 8.1) {
      SetIndex = '5';
    } else if (ballPosition > 8.1 && ballPosition <= 9.52) {
      SetIndex = '6';
    } else if (ballPosition > 9.52 && ballPosition <= 10.94) {
      SetIndex = '7';
    } else if (ballPosition > 10.94 && ballPosition <= 12.36) {
      SetIndex = '8';
    } else if (ballPosition > 12.36) {
      SetIndex = '9';
    }
    //   else if (ballPosition > 1.0) {
    //   SetIndex = '9';
    // }

    print(SetIndex);
    print('SetIndex');

    final response = await http.post(
      Uri.parse(ApiUrl.plinkoMultiplier),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"userid": token, "index": SetIndex}),
    );

    if (response.statusCode == 200) {
      print('api chalegi yaha');
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      print("responseData");
      fetchPlinkoData();
      return Fluttertoast.showToast(msg: responseData['message']);
    } else {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }

  String? type;
  String? multipler;
  String? win_amount;

  Future<List<PlinkoBetHistory>?> fetchPlinkoBet() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse("${ApiUrl.plinkoBetHistory}userid=$token&limit=1")).timeout(const Duration(seconds: 10));
      print("${ApiUrl.plinkoBetHistory}userid=$token&limit=1");
      print("ApiUrl.plinkoBetHistory");
      print(response);
      print("response bet history");

      if (response.statusCode == 200) {

        final jsonList = json.decode(response.body);
        print(jsonList);
        print("jsonList");
        if (jsonList['status'] == 200) {
          final List<dynamic> data = json.decode(response.body)['data'];

          if (data.isNotEmpty) {
            type = data[0]['type'].toString();
            multipler = data[0]['multipler'].toString();
            win_amount = data[0]['win_amount'].toString();
            print(type);
            print("type");
            print(multipler);
            print("multipler");
            print(win_amount);
            print("win_amount");
          }
          List<PlinkoBetHistory> plinkolist = data.map((jsonMap) => PlinkoBetHistory.fromJson(jsonMap)).toList();
          win_amount != '0'
              ? ToastHelper.showwin(subtext1: type, subtext2: win_amount)
              : ToastLostHelper.showloss(subtext1: type, subtext2: win_amount);

          return plinkolist;
        } else {
          print("else");
          return null;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<void> fetchPlinkoData() async {
    try {
      List<PlinkoBetHistory>? plinkoBetData = await fetchPlinkoBet();
      if (kDebugMode) {
        print(plinkoBetData);
        print("plinkoBetData");
      }
    } catch (error) {
      print('Error fetching plinko data: $error');
    }
  }

}


