// import 'dart:convert';
// import 'package:backend_testing/extensionMethods.dart';
// import 'package:flutter/material.dart';

// class Def {
//   Sseq sseq;

//   Def({required this.sseq});

//   factory Def.fromJson(List<dynamic> sseq) {
//     return Def(sseq: Sseq.fromJson(sseq[0]['sseq']));
//   }
// }

// class Sseq {
//   List<Sense> senses;

//   Sseq({required this.senses});

//   factory Sseq.fromJson(List<dynamic> sseq) {
//     final List<Sense> result = [];

//     for (dynamic subList in sseq) {
//       for (dynamic senseList in subList) {
//         try {
//           result.add(
//             Sense.fromJson(senseList[1]),
//           );
//         } catch (e) {
//           if(e != 'Ignore this sense') {
//             rethrow;
//           }
//         }
//       }
//     }

//     return Sseq(senses: result);
//   }
// }

// class Sense {
//   Dt dt;
//   SdSense? sdsense;

//   Sense({required this.dt, this.sdsense});

//   factory Sense.fromJson(Map<String, dynamic> json) {
//     final Map<String, dynamic>? sdsenseRaw = json['sdsense'];
//     final dtRaw = json['dt'];
//     if (dtRaw == null) {
//       throw 'Ignore this sense';
//     }
//     if (sdsenseRaw == null) {
//       return Sense(
//         dt: Dt.fromJson(json['dt']),
//       );
//     }
//     return Sense(
//       dt: Dt.fromJson(json['dt']),
//       sdsense: SdSense.fromJson(json['sdsense']),
//     );
//   }
// }

// class SdSense {
//   Dt dt;

//   SdSense({required this.dt});

//   factory SdSense.fromJson(Map<String, dynamic> json) {
//     return SdSense(dt: Dt.fromJson(json['dt']));
//   }
// }

// class Dt {
//   String? def;
//   String? exp;

//   Dt({this.def, this.exp});

//   factory Dt.fromJson(List<dynamic> dt) {
//     if (dt.length > 1 && dt[1].length > 1) {
//       return Dt(
//         exp: dt[1][1][0]['t'],
//         def: _removeNoise(dt[0][1]),
//       );
//     }
//     return Dt(
//       def: _removeNoise(dt[0][1]),
//     );
//   }

//   static String _removeNoise(String str) {
//     String ans = '';
//     bool ignore = false;

//     for (int i = 0, j = 0; i < str.length; i++) {
//       if (str[i] == '{') {
//         ignore = true;
//         continue;
//       }
//       if (str[i] == '}') {
//         ignore = false;
//         continue;
//       }
//       if (!ignore) {
//         ans += str[i];
//       }
//     }
//     return ans;
//   }
// }
