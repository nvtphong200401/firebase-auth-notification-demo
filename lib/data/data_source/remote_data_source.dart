
import 'package:demo_firebase/data/api.dart';
import 'package:demo_firebase/data/data_source/data_source.dart';


class RemoteDataSource extends DataSource {

  final Api api;

  RemoteDataSource({required this.api});

  @override
  Future getData(String fcmToken) {
    // TODO: implement postData
    throw UnimplementedError();
  }

  @override
  Future sendNotification(String title, String body, String fcmToken) async {
    print("sent");
    // Map<String, dynamic> jsonResponse = await api.post('',{
    //   // 'notification': {'body': body, 'title': title},
    //   'priority': 'high',
    //   'data': {
    //     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    //     'id': DateTime.now().millisecond,
    //     'status': 'done',
    //     'route' : '/detail',
    //     'body': body,
    //     'title': title
    //   },
    //   'to': '/topics/$fcmToken',
    // });
    Map<String, dynamic> jsonResponse = await api.post('', {
      "message": {
        "topic": "all",
        "notification": {
          "title": "Breaking News",
          "body": "New news story available."
        },
        "data": {
      "title": "Breaking News",
      "body": "New news story available.",
          "story_id": "story_12345"
        }
      }
    });
    return jsonResponse;
  }

}