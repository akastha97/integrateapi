import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:integrate_api/models/employee_model.dart';
import 'package:integrate_api/network/api_router.dart';

class ApiManager {
  static final ApiManager _singleton = new ApiManager._internal();

  factory ApiManager() {
    return _singleton;
  }

  ApiManager._internal();

  Future<List<PostModel>> fetchPosts() async {
    try {
      String url = ApiRouter.allEmployees;
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<PostModel> result =
            responseData.map((item) => PostModel.fromJson(item)).toList();
        return result;
      } else {
        return Future.error(response.statusCode);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
