import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/users.dart';
class UserService{
   
  Future<UserModel> fetchUser() async {
    
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/users/1")
    );

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception("Failed to load user");
    }
  }
}