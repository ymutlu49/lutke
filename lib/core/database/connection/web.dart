import 'package:drift/web.dart';

Future<WebDatabase> openConnection() async {
  return WebDatabase('lutke_v3');
}
