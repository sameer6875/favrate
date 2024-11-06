import 'package:flutter/material.dart';

class FavoriteUsersScreen extends StatelessWidget {
  final List<String> favoriteUsers;
  final List<dynamic> allUsers;

  const FavoriteUsersScreen(this.favoriteUsers, this.allUsers);

  @override
  Widget build(BuildContext context) {
    final favoriteUserData = allUsers.where((user) => favoriteUsers.contains(user['id'].toString())).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Favorite Users'),
      ),
      body: ListView.builder(
        itemCount: favoriteUserData.length,
        itemBuilder: (context, index) {
          final user = favoriteUserData[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user['avatar']),
            ),
            title: Text('${user['first_name']} ${user['last_name']}'),
            subtitle: Text(user['email']),
          );
        },
      ),
    );
  }
}