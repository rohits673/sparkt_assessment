import 'package:flutter/material.dart';

import 'package:sparkt_assessment/model/country.dart';
import 'package:sparkt_assessment/widget/avatar_widget.dart';

class CountryListTileWidget extends StatelessWidget {
  final Country country;
  final bool isSelected;
  final ValueChanged<Country> onSelectedCountry;

  const CountryListTileWidget({
    Key? key,
    required this.country,
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
        onTap: () => onSelectedCountry(country),
        leading: AvatarWidget(imageUrl: country.flag),
        title: Text(
          country.name,
          style: style,
        ),
        trailing: isSelected
            ? Icon(Icons.check, color: selectedColor, size: 26)
            : null,
      ),
    );
  }
}
