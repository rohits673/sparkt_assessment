import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sparkt_assessment/model/user.dart';
import 'package:sparkt_assessment/provider/user_provider.dart';
import 'package:sparkt_assessment/widget/search_widget.dart';
import 'package:sparkt_assessment/widget/user_listtile_widget.dart';

class UserPage extends StatefulWidget {
  final List<User> users;
  const UserPage({
    Key? key,
    this.users = const [],
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String text = '';
  List<User> selectedUser = [];

  @override
  void initState() {
    super.initState();
    selectedUser = widget.users;
  }

  bool containsSearchText(User user) {
    final name = user.firstName;
    final textLower = text.toLowerCase();
    final userLower = name.toLowerCase();
    return userLower.contains(textLower);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    var users = provider.users.where(containsSearchText).toList();

    Future refreshData() async {
      provider.setUsers([]);
      setState(() {
        provider.loadUsers().then((users) {
          provider.setUsers(users);
        });
      });
    }

    return Scaffold(
      appBar: buildAppBar() as PreferredSizeWidget,
      body: Column(
        children: <Widget>[
          Expanded(
              child: users.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: refreshData,
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          final isSelected =
                              selectedUser.contains(users[index]);
                          return UserListTileWidget(
                            user: users[index],
                            isSelected: isSelected,
                            onSelectedCountry: selectUser,
                          );
                        },
                      ))
                  : Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator())),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    const label = 'User';

    return AppBar(
      title: const Text('Select $label'),
      actions: const [
        SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'Search $label',
        ),
      ),
    );
  }

  void selectUser(User user) {
    context.read<UserProvider>().setSelected(user);
    Navigator.pop(context);
  }
}
