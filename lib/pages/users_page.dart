import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/models.dart';

class UsersPage extends StatefulWidget {

  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  final users = [
    User(uid:  '1', firstName: 'Maria', lastName: 'Anaya', email: 'user1@test.com', onLine: true),
    User(uid:  '2', firstName: 'Jose', lastName: 'Cardenas', email: 'user2@test.com', onLine: false),
    User(uid:  '3', firstName: 'Pedro', lastName: 'Medina', email: 'user3@test.com', onLine: true),
    User(uid:  '4', firstName: 'Juan', lastName: 'Espinoza', email: 'user4@test.com', onLine: true),
    User(uid:  '5', firstName: 'Carlos', lastName: 'Cordova', email: 'user5@test.com', onLine: false),
    User(uid:  '6', firstName: 'Luis', lastName: 'Castillo', email: 'user6@test.com', onLine: true),
    User(uid:  '7', firstName: 'Ana', lastName: 'Silva', email: 'user7@test.com', onLine: false),
    User(uid:  '8', firstName: 'Sofia', lastName: 'Carrillo', email: 'user8@test.com', onLine: false),
    User(uid:  '9', firstName: 'Luisa', lastName: 'Durand', email: 'user9@test.com', onLine: true),
    User(uid: '10', firstName: 'Laura', lastName: 'Ramos', email: 'user10@test.com', onLine: true)
  ];

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Page', style: TextStyle(color: Colors.black54)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.check_circle, color: Colors.blue),
            // child: const Icon(Icons.offline_bolt, color: Colors.red),
            // child: const Icon(Icons.offline_bolt, color: Colors.grey),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          _refreshController.refreshCompleted();
        },
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _usersListView(),
      )
   );
  }

  ListView _usersListView() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => _userListTile(users[index]),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.fullName),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.firstName.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.onLine ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100)
        ),
      )
    );
  }
}