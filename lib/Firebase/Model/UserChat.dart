



import '../Utils/utils.dart';

class UserChat {
  String ?idd;
  final String ?idUser;
  final String ?name;
  bool ?read;
  var block;
  var status;
  final String ?urlAvatar;
  final Map? shipment;
  final String ?project_owner_user_id;
  final String ?bid_id;
  final String ?job_id;
  final serviceId;
  final String ?service_id;
  final id;
  final String ?docid;
  final String ?fcmToken;
  var lastMessageTime;
  final String ?lastMessage;
  final String ?userMobile;

  UserChat({
    this.idd,
    this.name,
    this.idUser,
    this.block,
    this.read,
    this.status,
    this.urlAvatar,
    this.serviceId,
    this.fcmToken,
    this.docid,
    this.shipment,
    this.lastMessage,
    this.id,
    this.bid_id,
    this.job_id,
    this.project_owner_user_id,
    this.service_id,
    this.userMobile,
    this.lastMessageTime,
  });

  UserChat.fromMap(snapshot, String id)
      : idd = id,
        name = snapshot!['name'] ?? '',
        bid_id = snapshot['bid_id'] ?? '',
        job_id = snapshot['project_id'] ?? '',
        shipment = snapshot['shipment']?? {},
        service_id = snapshot['service_id'] ?? '',
        read = snapshot['read'] ?? '',
        id = snapshot['recieveruserId']??'',
        fcmToken = snapshot['token']?? '',
        lastMessage = snapshot['lastMessage'] ?? '',
        lastMessageTime = Utils.toDateTime(snapshot['lastMessageTime']),
        block = snapshot['block'] ?? '',
        serviceId = snapshot['serviceId']??'',
        idUser = snapshot['idUser'] ?? '',
        docid = snapshot['docid'] ?? '',
        project_owner_user_id = snapshot['project_owner_user_id'] ?? '',
        urlAvatar = snapshot['urlAvatar'] ?? '',
        userMobile = snapshot['userMobile'] ?? '',
        status = snapshot['status'] ?? '';

  toJson() {
    return {
      "name": name,
      'project_owner_user_id': project_owner_user_id,
      "read": read,
      'token':fcmToken,
      'bid_id': bid_id,
      'project_id': job_id,
      'shipment': shipment,
      'recieveruserId': id,
      'serviceId': serviceId,
      'service_bid': service_id,
      'id': idd,
      'lastMessage': lastMessage,
      'lastMessageTime': Utils.toDateTime(lastMessageTime),
      'block': block,
      'idUser': idUser,
      'docid': docid,
      'urlAvatar': urlAvatar,
      'userMobile': userMobile,
      'status': status,
    };
  }
}










class NotifyModel {
  String ?idd;
  final String ?reciever;
  final String ?title;
  final String ?deliveryID;
  final String ?date;
  final String ?body;


  NotifyModel({
    this.idd,
    this.reciever,
    this.title,
    this.deliveryID,
    this.date,
    this.body,
  });

  NotifyModel.fromMap(snapshot, String id)
      : idd = id,
        reciever = snapshot!['reciever'] ?? '',
        title = snapshot['title'] ?? '',
        date = snapshot['date'] ?? '',
        deliveryID = snapshot['deliveryID']?? {},
        body = snapshot['body'] ?? '';

  toJson() {
    return {
      "reciever": reciever,
      'title': title,
      "date": date,
      'deliveryID':deliveryID,
      'body': body,
      'id': idd,
    };
  }
}
