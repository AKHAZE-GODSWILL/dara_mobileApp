import 'package:flutter/material.dart';

import '../Utils/utils.dart';


class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final id;
  final String? callerId;
  final String? callStatus;
  final String? idUser;
  final String? urlAvatar;
  final String? username;
  final String? message;
  final String? productImage;
  final String? calltype;
  final String? media_type;
  final chatId;
  final DateTime? createdAt;
  final bool? read;

  const Message({
    this.id,
    this.callerId,
    this.productImage,
    this.calltype,
    @required this.idUser,
    this.chatId,
    this.callStatus,
    this.media_type,
    @required this.urlAvatar,
    @required this.username,
    @required this.message,
    @required this.createdAt,
    @required this.read,
  });

  Message.fromMap(snapshot, String id)        
      : read = snapshot['read'],
        id = id,
        chatId = snapshot['chatId'] ?? '',
        message = snapshot['message'] ?? '',
        calltype = snapshot['calltype'] ?? '',
        productImage = snapshot['productImage'] ?? '',
        callerId = snapshot['callerId'] ?? '',
        idUser = snapshot['idUser'] ?? '',
        urlAvatar = snapshot['urlAvatar'] ?? '',
        callStatus = snapshot['callStatus'] ?? '',
        username = snapshot['username'] ?? '',
        media_type = snapshot['media_type']??'',
        createdAt = Utils.toDateTime(snapshot['createdAt']);

  Map<String, dynamic> toJson() => {
        'calltype': calltype,
        'idUser': idUser,
        'callerId': callerId,
        'chatId': chatId,
        'urlAvatar': urlAvatar,
        'productImage': productImage,
        'callStatus': callStatus,
        'username': username,
        'message': message,
        'media_type':media_type,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
      };
}
