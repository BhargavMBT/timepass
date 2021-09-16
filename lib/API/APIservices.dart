import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/main.dart';
import 'package:http/http.dart' as http;

class APIServices {
  Future getProfile() async {
    try {
      var url = Uri.parse('$weburl/profile');
      var response;
      if (xAccessToken != null) {
        response = await http.get(url, headers: {
          'x-access-token': xAccessToken!,
        });
        if (response.statusCode == 200) {
          return response.body;
        } else {
          throw Exception("Oops! Something went wrong");
        }
      } else {
        throw Exception("Oops! Something went wrong");
      }
    } catch (e) {
      throw Exception("Oops! Something went wrong");
    }
  }
   Future getProfileofChatUsers(String uid) async {
    try {
      var url = Uri.parse('$weburl/users/search?_id=$uid');
      var response;
      if (xAccessToken != null) {
        response = await http.get(
          url,
        );
        if (response.statusCode == 200) {
          // print(response.body);
          return response.body;
        } else {
          throw Exception("Oops! Something went wrong");
        }
      } else {
        throw Exception("Oops! Something went wrong");
      }
    } catch (e) {
      throw Exception("Oops! Something went wrong");
    }
  }
}
