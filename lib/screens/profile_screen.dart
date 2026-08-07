import 'package:flutter/material.dart';
import '../models/users.dart';
import '../services/user_service.dart';


class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}



class _ProfileScreenState extends State<ProfileScreen> {

  final UserService _userService = UserService();

  UserModel? user;

  bool isLoading = true;


  @override
  void initState() {
    super.initState();

    loadUser();
  }


  Future<void> loadUser() async {

    try {

      final result = await _userService.fetchUser();

      setState(() {

        user = result;
        isLoading = false;

      });


    } catch(e) {

      print(e);

    }

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),


      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )


          : Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),


            const SizedBox(height: 20),


            Text(
              "${user!.firstName} ${user!.lastName}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 10),


            Text(
              "Username: ${user!.username}",
            ),


            const SizedBox(height: 10),


            Text(
              "Email: ${user!.email}",
            ),

          ],
        ),
      ),
    );
  }
}