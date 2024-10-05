import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';
import 'package:flowkit/services/pages/user_configuration/getMenuAuthorization_api.dart';

class UpdateMenuAuthApi {
  String? message;
  int? stcode;
  UpdateMenuAuthApi({required this.message, required this.stcode});

  static Future<UpdateMenuAuthApi> call(
      List<GetMenuAuthData>? posBodymenuData) async {
    Responce res = Responce();
    List<Map<String, dynamic>>? data =
        posBodymenuData!.map((e) => e.tojson()).toList();
    UtilsVariables.token = await SharedPre.getToken();

    print(data);
    res = await ServicePost.callApi(
        '${UtilsVariables.url}/UpdateMenuAuth', UtilsVariables.token, {},
        listbody: data);
    return UpdateMenuAuthApi.fromjson(res);
  }

  factory UpdateMenuAuthApi.fromjson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      return UpdateMenuAuthApi(message: 'Sucess', stcode: res.resCode);
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      return UpdateMenuAuthApi(message: 'Failure', stcode: res.resCode);
    } else {
      return UpdateMenuAuthApi(message: res.responceBody, stcode: res.resCode);
    }
  }
}
