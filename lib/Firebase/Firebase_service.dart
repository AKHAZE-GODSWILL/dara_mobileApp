// import 'package:fixme/Services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:goldenpay/Firebase/Utils/utils.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'Model/Message.dart';
import 'Model/User.dart';
import 'Utils/utils.dart';

class FirebaseApi {
  static GetStorage box = GetStorage();
  static Stream getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots();

  static Future uploadmessage(
      String idUser, String idArtisan, String message, context, chatId, fullname,
      {productImage}) async {
    var utils = Provider.of<Utils>(context, listen: false);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? fullname = prefs.getString('fullname');
    // String? phone = prefs.getString('phonenumber');
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages').doc();
    final refMessages2 = FirebaseFirestore.instance
        .collection('chats/$idArtisan/messages')
        .doc();

    final newMessage = {
      'productImage': productImage,
      'chatId': chatId ?? '',
      'idUser': utils.userId,
      'urlAvatar':
          'https://uploads.fixme.ng/thumbnails/${'network.profilePicFileName'}',
      'username': fullname ?? '',
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
      'read': false
    };

    await refMessages.set(newMessage);

    await refMessages2.set(newMessage);

    final refUsers =
        FirebaseFirestore.instance.collection('UserChat/$idUser/individual');
    final refArtisan =
        FirebaseFirestore.instance.collection('UserChat/$idArtisan/individual');
    await refArtisan.doc(idUser).update({
      UserField.lastMessageTime: DateTime.now(),
      'lastMessage': '$message',
      'read': false,
    });

    await refUsers.doc(idArtisan).update({
      UserField.lastMessageTime: DateTime.now(),
      'lastMessage': '$message',
      'read': false,
    });
  }

  static Future uploadImage(
      String idUser, idArtisan, message, context, chatId, file, fullname) async {
    var utils = Provider.of<Utils>(context, listen: false);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? fullname = prefs.getString('fullname');
    // String? phone = prefs.getString('phonenumber');
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages').doc();
    final refMessages2 = FirebaseFirestore.instance
        .collection('chats/$idArtisan/messages')
        .doc();

    Reference storageReferenceImage = FirebaseStorage.instance.ref().child(
        'image/${Path.basename(file ? message.paths[0] : message.path)}');

    UploadTask uploadtask = storageReferenceImage
        .putFile(File(file ? message.paths[0] : message.path));
    uploadtask.then((res) {
      storageReferenceImage.getDownloadURL().then((imageurl) async {
        final newMessage = {
          'chatId': chatId ?? '',
          'idUser': utils.userId,
          'urlAvatar':
              'https://uploads.fixme.ng/thumbnails/${'network.profilePicFileName'}',
          'username': fullname,
          'message': imageurl,
          'createdAt': FieldValue.serverTimestamp(),
        };

        refMessages.set(newMessage);
        await refMessages2.set(newMessage);
      });
    });

    final refUsers =
        FirebaseFirestore.instance.collection('UserChat/$idUser/individual');
    final refArtisan =
        FirebaseFirestore.instance.collection('UserChat/$idArtisan/individual');
    await refArtisan.doc(idUser).update({
      UserField.lastMessageTime: DateTime.now(),
      'lastMessage': 'A File',
      'read': false,
    });

    await refUsers.doc(idArtisan).update({
      UserField.lastMessageTime: DateTime.now(),
      'lastMessage': 'A File',
      'read': false,
    });
  }

  static Future uploadRecord(
      String idUser, idArtisan, message, context, chatId, fullname) async {
    var utils = Provider.of<Utils>(context, listen: false);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? fullname = prefs.getString('fullname');
    // String? phone = prefs.getString('phonenumber');
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages').doc();
    final refMessages2 = FirebaseFirestore.instance
        .collection('chats/$idArtisan/messages')
        .doc();

    Reference storageReferenceImage = FirebaseStorage.instance
        .ref()
        .child('image/${Path.basename(message.path)}');

    UploadTask uploadTask = storageReferenceImage.putFile(File(message.path));
    uploadTask.then((res) {
      storageReferenceImage.getDownloadURL().then((imageurl) async {
        final newMessage = {
          'chatId': chatId ?? '',
          'idUser': utils.userId,
          'urlAvatar':
              'https://uploads.fixme.ng/thumbnails/${'network.profilePicFileName'}',
          'username': fullname,
          'message': imageurl,
          'createdAt': FieldValue.serverTimestamp(),
        };

        refMessages.set(newMessage);
        await refMessages2.set(newMessage);
      });
    });

    final refUsers =
        FirebaseFirestore.instance.collection('UserChat/$idUser/individual');
    final refArtisan =
        FirebaseFirestore.instance.collection('UserChat/$idArtisan/individual');
    await refArtisan.doc(idUser).update({
      UserField.lastMessageTime: DateTime.now(),
      'lastMessage': 'A File',
      'read': false,
    });

    await refUsers.doc(idArtisan).update({
      UserField.lastMessageTime: DateTime.now(),
      'lastMessage': 'A File',
      'read': false,
    });
  }

  static Stream<QuerySnapshot> getMessages(String idUser, chatId1, chatId2) {
    return FirebaseFirestore.instance
        .collection('chats/$idUser/messages')
        .where('chatId', whereIn: [chatId1, chatId2])
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots();
  }

  static changeIndividualReadChats() async {    
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = box.read('userId');

    var documentReference = FirebaseFirestore.instance
        .collection('chats/$userid/messages')
        .where('read', isEqualTo: false);
    documentReference.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        await updateReadReceipt(doc.id, userid);
      });
    });
  }

  static updateReadReceipt(id, userid) async {
    var documentReference =
        FirebaseFirestore.instance.collection('chats/$userid/messages');
    await documentReference.doc(id).update({
      'read': true,
    });
  }

  static clearMessage(String idUser, chatId1, chatId2) {
    var documentReference = FirebaseFirestore.instance
        .collection('chats/$idUser/messages')
        .where('chatId', whereIn: [chatId1, chatId2]);

    documentReference.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  static Future addUserChat({
    // required DeliveryMainModel shipment,
    idUser,
    name,
    urlAvatar,
    docid,
    idArtisan,
    name2,
    urlAvatar2,
    userMobile,
    recieveruserId2,
    recieveruserId,
    artisanMobile,
    token,
    token2,
  }) async {
    final refUsers =
        FirebaseFirestore.instance.collection('UserChat/$idArtisan/individual');
    final refAritisan =
        FirebaseFirestore.instance.collection('UserChat/$idUser/individual');
    await refUsers.doc(idArtisan).set({
      // "shipment": shipment.toJson(),
      'chatid': idArtisan,
      'read': false,
      'idUser': idUser,
      'name': name,
      'token': token,
      'recieveruserId': recieveruserId,
      'block': false,
      'userMobile': userMobile,
      'lastMessage': '',
      'urlAvatar': urlAvatar,
      'lastMessageTime': DateTime.now(),
    });

    await refAritisan.doc(idUser).set({
      // "shipment":  shipment.toJson(),
      'chatid': idUser,
      'read': false,
      'block': false,
      'idUser': idArtisan,
      'lastMessage': '',
      'name': name2,
      'recieveruserId': recieveruserId2,
      'token': token2,
      'userMobile': artisanMobile,
      'urlAvatar': urlAvatar2,
      'lastMessageTime': DateTime.now(),
    });
  }

  static Future addUserBidChat({
    token,
    token2,
    bidData,
    idUser,
    name,
    urlAvatar,
    docid,
    recieveruserId2,
    recieveruserId,
    serviceId,
    serviceId2,
    idArtisan,
    name2,
    urlAvatar2,
    userMobile,
    artisanMobile,
  }) async {
    final refUsers =
        FirebaseFirestore.instance.collection('UserChat/$idArtisan/individual');
    final refAritisan =
        FirebaseFirestore.instance.collection('UserChat/$idUser/individual');
    await refUsers.doc(idUser).set({
      'bid_id': bidData.bid_id ?? '',
      'project_id': bidData.job_id ?? '',
      'project_owner_user_id': bidData.project_owner_user_id ?? '',
      'service_id': bidData.service_id ?? '',
      'chatid': idArtisan,
      'read': false,
      'idUser': idUser,
      'name': name,
      'serviceId': serviceId ?? '',
      'token': token,
      'recieveruserId': recieveruserId,
      'block': false,
      'userMobile': userMobile,
      'lastMessage': '',
      'urlAvatar': urlAvatar,
      'lastMessageTime': DateTime.now(),
    });
    await refAritisan.doc(idArtisan).set({
      'bid_id': bidData.bid_id ?? '',
      'project_id': bidData.job_id ?? '',
      'project_owner_user_id': bidData.project_owner_user_id ?? '',
      'service_id': bidData.service_id ?? '',
      'chatid': idUser,
      'read': false,
      'token': token2,
      'recieveruserId': recieveruserId2,
      'block': false,
      'serviceId': serviceId ?? '',
      'idUser': idArtisan,
      'lastMessage': '',
      'name': name2,
      'userMobile': artisanMobile,
      'urlAvatar': urlAvatar2,
      'lastMessageTime': DateTime.now(),
    });
  }

  static Stream<QuerySnapshot> userChatStream(chatid) {
   
    var data = FirebaseFirestore.instance
        .collection('UserChat/$chatid/individual');
        // .where('chatid', isEqualTo: 1.toString());
    return data.snapshots();
  }


  static Stream<QuerySnapshot> userNotificationStream(userid) {
    var data = FirebaseFirestore.instance
        .collection('notification').where("reciever", isEqualTo: userid);
    // .where('chatid', isEqualTo: 1.toString());
    return data.snapshots();
  }

  // static Stream<QuerySnapshot> userNotificatioStream(id) {
  //   var data = FirebaseFirestore.instance
  //       .collection('Notification')
  //       .where('userid', isEqualTo: id).orderBy('createdAt', descending: true);
  //   return data.snapshots();
  // }
  //
  // static Stream<QuerySnapshot> userCheckNotifyStream(id) {
  //   var data = FirebaseFirestore.instance
  //       .collection('CheckNotify')
  //       .where('userid', isEqualTo: id);
  //   return data.snapshots();
  // }
  //

   clearShipment() {
    String userid = box.read('userId');
    var documentReference = FirebaseFirestore.instance
        .collection('shipment')
        .where('owner' , isEqualTo: userid);

    documentReference.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  static Stream<QuerySnapshot> userCheckChatStream(id) {
    var data = FirebaseFirestore.instance
        .collection('UserChat/3/individual')
        .where('chatid', isEqualTo: id);
    return data.snapshots();
  }

  static clearCheckChat(String id) {
    var documentReference = FirebaseFirestore.instance
        .collection('CheckChat')
        .where('userid', isEqualTo: id);

    documentReference.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  static Future uploadCheckNotify(
    String id,
  ) async {
    final refMessages = FirebaseFirestore.instance.collection('CheckNotify');

    await refMessages.doc().set({
      'userid': id,
      'createdAt': DateTime.now(),
    });
  }

  static Future uploadCheckChat(
    String id,
  ) async {
    final refMessages = FirebaseFirestore.instance.collection('CheckChat');

    await refMessages.doc().set({
      'userid': id,
      'createdAt': DateTime.now(),
    });
  }

  static Future uploadNotification(String id, String message, type, name, jobId,
      bidId, bidderId, artisanId, budget, invoiceId, serviceId) async {
    final refMessages = FirebaseFirestore.instance.collection('Notification');

    await refMessages.doc().set({
      'userid': id,
      'message': message,
      'jobId': jobId,
      'type': type,
      'name': name,
      'artisanId': artisanId,
      'bidded': 'bid',
      'bidderId': bidderId ?? '',
      'bidId': bidId ?? '',
      'invoice_id': invoiceId ?? '',
      'servicerequestId': serviceId ?? '',
      'budget': budget ?? '',
      'createdAt': DateTime.now(),
    });
  }

  static Future deleteNotification(String id) async {
    final refMessages = FirebaseFirestore.instance.collection('Notification');
    await refMessages.doc(id).delete();
  }



  static Future deletePlacedOrder(String id) async {
    final refPlacedOrder = FirebaseFirestore.instance.collection('placedOrder');
    await refPlacedOrder.doc(id).delete();
  }



  static Future updateNotification(String id, message) async {
    final refMessages = FirebaseFirestore.instance.collection('Notification');

    await refMessages.doc(id).update({
      'type': message,
      'createdAt': DateTime.now(),
    });
  }

  static Stream<QuerySnapshot> userChatStreamUnread(chatid) {
    var data = FirebaseFirestore.instance
        .collection('UserChat/$chatid/individual')
        .where('chatid', isEqualTo: chatid)
        .where('read', isEqualTo: false);
    return data.snapshots();
  }

  static Stream<QuerySnapshot> userChatStreamread(chatid) {
    var data = FirebaseFirestore.instance
        .collection('UserChat/$chatid/individual')
        .where('chatid', isEqualTo: chatid)
        .where('read', isEqualTo: true);
    return data.snapshots();
  }

  static updateUsertoRead({
    String? idUser,
    String? idArtisan,
  }) async {
    final refUsers =
        FirebaseFirestore.instance.collection('UserChat/$idArtisan/individual');
    await refUsers.doc(idUser).update({
      'read': true,
    });
  }


  static updateUsertoReadNotify({
    user
  }) async {
    final refUsers =
    FirebaseFirestore.instance.collection('UserChat/$user/individual');
    await refUsers.doc("1").update({
      'read': true,
    });
  }

  static updateUserFCMToken({String? idUser, String? idArtisan, token}) async {
    final refUsers =
        FirebaseFirestore.instance.collection('UserChat/$idUser/individual');
    await refUsers.doc(idArtisan).update({
      'token': token,
    });
  }
}
