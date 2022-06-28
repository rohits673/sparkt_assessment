import 'dart:convert';
import 'package:sparkt_assessment/model/user.dart';
import 'package:sparkt_assessment/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    loadUsers().then((users) {
      _users = users;
      notifyListeners();
    });
  }

  List<User> _users = [];

  void setUsers(List<User> user) {
    _users = user;
    notifyListeners();
  }

  List<User> get users => _users;

  Future loadUsers() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?per_page=12'));
    if (response.statusCode == 200) {
      Map responseJson = json.decode(response.body);
      List userJson = responseJson["data"];
      return _users = userJson.map((data) => User.fromJson(data)).toList()
        ..sort(UserUtils.ascendingSort);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
