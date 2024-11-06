import 'package:flutter/material.dart';
import 'package:nextdayfevrate/apis/api_services.dart';
import 'package:nextdayfevrate/local_storage/local_storage.dart';
import 'package:nextdayfevrate/screen/favoriteUsersScreen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<dynamic> users = [];
  List<String> favoriteUsers = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    users = await ApiService.fetchUsers();
    favoriteUsers = await LocalStorageService.getFavoriteUsers();
    setState(() {});
  }

  void _toggleFavorite(String userId) async {
    setState(() {
      if (favoriteUsers.contains(userId)) {
        favoriteUsers.remove(userId);
      } else {
        favoriteUsers.add(userId);
      }
    });
    await LocalStorageService.saveFavoriteUsers(favoriteUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reqres Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FavoriteUsersScreen(favoriteUsers, users)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final userId = user['id'].toString();
          final isFavorite = favoriteUsers.contains(userId);

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user['avatar']),
            ),
            title: Text('${user['first_name']} ${user['last_name']}'),
            subtitle: Text(user['email']),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () => _toggleFavorite(userId),
            ),
          );
        },
      ),
    );
  }
}
