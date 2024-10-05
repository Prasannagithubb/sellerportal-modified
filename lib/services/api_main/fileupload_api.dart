import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FileUploadApi {
  int? stcode;
  String? imgUrl;
  FileUploadApi({this.stcode, this.imgUrl});

  static Future<FileUploadApi> uploadImage(
    PlatformFile imageFilePath,
  ) async {
    var uri = Uri.parse(
        'http://tvc.Sellerkit.in:81/api/SKClientPortal/UploadProfileMedia?filename=${imageFilePath.name}');
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile.fromBytes(
        'formFile', imageFilePath.bytes!,
        filename: imageFilePath.name,
        contentType: MediaType('application/octet-stream', 'any'));
    var headers = {
      'Authorization': 'bearer ${UtilsVariables.token}',
      "content-type": "application/json",
    };
    request.headers.addAll(headers);
    request.files.add(multipartFile);

    var response = await request.send();
    String result = '';
    if (response.statusCode <= 210) {
      response.stream.transform(utf8.decoder).listen((value) async {
        print(value);

        String result2 = value;
        result = result2;
        print(result);
      });
      await Future.delayed(Duration(milliseconds: 100));

      return FileUploadApi.fromJson(result, response.statusCode);
    } else {
      return FileUploadApi.fromJson('', 500);
    }
  }

  factory FileUploadApi.fromJson(String? json, int stcode) {
    if (stcode <= 210 && stcode >= 200) {
      return FileUploadApi(stcode: stcode, imgUrl: json.toString());
    } else if (stcode <= 410 && stcode >= 400) {
      return FileUploadApi(stcode: stcode, imgUrl: null);
    } else {
      return FileUploadApi(stcode: stcode, imgUrl: null);
    }
  }
}
