import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_app/controllers/search_controllers.dart';
import 'package:med_app/models/users.dart';
import 'package:med_app/views/screen/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController _controller = Get.put(SearchController());
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            controller: _editingController,
            onFieldSubmitted: (value) => _controller.searchUser(value),
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search',
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: _controller.searchUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for Users',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              )
            : ListView.builder(
                itemCount: _controller.searchUsers.length,
                itemBuilder: (context, index) {
                  Users users = _controller.searchUsers[index];
                  return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ProfileScreen(uid: users.uid);
                        }));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users.profilePhoto),
                        ),
                        title: const Text('username'),
                      ));
                },
              ),
      );
    });
  }
}
