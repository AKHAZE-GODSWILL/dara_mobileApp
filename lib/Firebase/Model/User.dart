// import 'package:goldenpay/Firebase/Utils/utils.dart';
import 'package:meta/meta.dart';

import '../Utils/utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  final String? idUser;
  final String name;
  final bool? read;
  final bool? block;
  final bool? status;
  final String? id;
  final String urlAvatar;
  final String? docid;
  final DateTime? lastMessageTime;
  final String lastMessage;
  final String? userMobile;
  final String? fcmToken;

  const User({
    this.idUser,
    this.read,
    this.userMobile,
    this.block,
    this.docid,
    this.id,
    this.status,
    this.fcmToken,
    required this.name,
    required this.lastMessage,
    required this.urlAvatar,
    required this.lastMessageTime,
  });

  User.fromMap(Map json, String id)
      : idUser = json['idUser'],
        read = json['read'],
        name = json['name'],
        id = json['id'],
        block = json['block'],
        status = json['[status'],
        userMobile = json['userMobile'],
        docid = id ?? '',
        fcmToken =json["fcmToken"] ,
        lastMessage = json['lastMessage'],
        urlAvatar = json['urlAvatar'],
        lastMessageTime = Utils.toDateTime(json['lastMessageTime']);




  User copyWith({
    String? idUser,
    String? docid,
    String? userMobile,
    String? id,
    String? name,
    String? fcmToken,
    bool? block,
    bool? read,
    bool? status,
    String? urlAvatar,
    String? lastMessage,
    DateTime? lastMessageTime,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        docid: docid ?? this.docid,
        block: block ?? this.block,
        id: id ?? this.id,
        read: read ?? this.read,
        userMobile: userMobile ?? this.userMobile,
        status: status ?? this.status,
        lastMessage: lastMessage ?? this.lastMessage,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        fcmToken: fcmToken?? this.fcmToken
      );

  static User fromJson([Map<String, dynamic>? json, id]) => User(
        idUser: json!['idUser'],
        read: json['read'],
        name: json['name'],
        id: json['id'],
        block: json['block'],
        status: json['[status'],
        userMobile: json['userMobile'],
        docid: id ?? '',
        lastMessage: json['lastMessage'],
        urlAvatar: json['urlAvatar'],
        fcmToken: json["fcmToken"],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'read': read,
        'docid': docid,
        'userMobile': userMobile,
        'name': name,
        'status': status,
        "id": id,
        'block': block,
        'lastMessage': lastMessage,
        'urlAvatar': urlAvatar,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime!),
        'fcmToken':fcmToken
      };
}
