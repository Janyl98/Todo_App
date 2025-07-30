import 'dart:io' show Platform;

final String baseURL = Platform.isAndroid
    ? "http://10.0.2.2:9191/tasks"
    : "http://127.0.0.1:9191/tasks";
const Map<String, String> headers = {"Content-Type": "application/json"};
