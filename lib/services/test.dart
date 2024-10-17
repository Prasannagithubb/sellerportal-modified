import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetTetApi {
  static Future<String> getmethod(String url) async {
    Responce res = Responce();
    res = await ServiceGetTest.callApi(
      url,
    );
    return res.responceBody!.toString();
  }
}
