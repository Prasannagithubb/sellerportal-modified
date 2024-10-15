import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetTetApi {
  static Future<String> getmethod() async {
    Responce res = Responce();
    res = await ServiceGetTest.callApi(
      'https://catfact.ninja/fact',
    );
    return res.responceBody!.toString();
  }
}
