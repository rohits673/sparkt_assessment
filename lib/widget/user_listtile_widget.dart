import 'package:flutter/material.dart';

import 'package:sparkt_assessment/model/user.dart';
import 'package:sparkt_assessment/widget/avatar_widget.dart';

class UserListTileWidget extends StatelessWidget {
  final User user;
  final bool isSelected;
  final ValueChanged<User> onSelectedCountry;

  const UserListTileWidget({
    Key? key,
    required this.user,
    required this.isSelected,
    required this.onSelectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(
            fontSize: 18,
            color: selectedColor,
            fontWeight: FontWeight.bold,
          )
        : const TextStyle(fontSize: 18);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        onTap: () => onSelectedCountry(user),
        leading: AvatarWidget(imageUrl: user.avatar),
        title: Text(
          " ${user.firstName} ${user.lastName}",
          style: style,
        ),
        trailing: isSelected
            ? Icon(Icons.check, color: selectedColor, size: 26)
            : null,
      ),
    );
  }
}
