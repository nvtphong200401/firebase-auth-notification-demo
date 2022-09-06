
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/model/message_model.dart';

class MessageController extends ChangeNotifier {
  List<MessageModel> messageList = [];
  RemoteDataSource sender = RemoteDataSource(api: Api());

  void add(MessageModel message){
    messageList.add(message);
    notifyListeners();
  }

  Future sendNotification(String title, String body) async {
    final response = await sender.sendNotification(title, body, 'all');
    print("sent success");
  }
}

final messageController = ChangeNotifierProvider((ref) => MessageController());