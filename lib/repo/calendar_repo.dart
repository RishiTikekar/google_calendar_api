import 'package:google_sign_in/google_sign_in.dart';
import 'package:testtask/models/task.dart';
import 'package:testtask/utils/app_config.dart';
import 'package:testtask/utils/service_locator.dart';

class CalenderRepo {
  final ApiUtil _util = getIt<ApiUtil>();

  Future<void> createCalenderEvent(
      Task task, Map<String, dynamic> headers) async {
    headers.remove('X-Goog-AuthUser');
    await _util.post(
      path: 'primary/events',
      queryParameters: {'key': AppConfig.apiKey},
      headers: headers,
      body: {
        'description': task.description,
        "start": {
          "dateTime": task.startTime.toIso8601String(),
          "timeZone": "GMT+5:30"
        },
        "end": {
          "dateTime": task.endTime.toIso8601String(),
          "timeZone": "GMT+5:30"
        },
        'summary': task.title,
      },
    );
  }

  Future<Map<String, String>?> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
      'https://www.googleapis.com/auth/calendar',
      'https://www.googleapis.com/auth/calendar.events',
    ]).signIn();

    Map<String, String>? headers = await googleUser?.authHeaders;

    return headers;
  }
}
