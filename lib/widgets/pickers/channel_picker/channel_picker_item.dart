import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/channel.dart';

class ChannelPickerItem extends StatelessWidget {
  final Channel channel;
  final bool isSelected;
  final ValueChanged<Channel> onSelectedChannel;

  ChannelPickerItem({
    required this.channel,
    required this.isSelected,
    required this.onSelectedChannel,
  });

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

    return ListTile(
      onTap: () => onSelectedChannel(channel),
      leading: const Icon(Icons.location_on_outlined,
          color: Constants.COLOR_SECONDARY),
      title: Text(
        channel.name,
        style: style,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
