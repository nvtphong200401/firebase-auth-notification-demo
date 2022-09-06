
abstract class DataSource {
  Future getData(String fcmToken);
  Future sendNotification(String title, String body, String fcmToken);
}